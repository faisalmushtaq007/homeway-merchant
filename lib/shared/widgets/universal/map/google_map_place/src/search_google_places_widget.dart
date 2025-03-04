part of google_places_for_flutter;

class SearchGooglePlacesWidget extends StatefulWidget {
  SearchGooglePlacesWidget({
    @required this.apiKey,
    this.placeholder = 'Search',
    this.icon = Icons.search,
    this.hasClearButton = true,
    this.clearIcon = Icons.clear,
    this.iconColor = Colors.blue,
    required this.onSelected,
    required this.onSearch,
    this.language = 'en',
    this.location,
    this.radius,
    this.strictBounds = false,
    this.placeType,
    this.darkMode = false,
    this.key,
    required this.onNewSelected,
    required this.onNewSearch,
    required this.outerMarginOfSearchTextField,
    this.newPlaceType,
  })  : assert((location == null && radius == null) ||
            (location != null && radius != null)),
        super(key: key);

  final Key? key;

  /// API Key of the Google Maps API.
  final String? apiKey;

  /// Placeholder text to show when the user has not entered any input.
  final String? placeholder;

  /// The callback that is called when one Place is selected by the user.
  final void Function(Place place) onSelected;
  final void Function(GBSearchData place) onNewSelected;

  /// The callback that is called when the user taps on the search icon.
  final void Function(Place place) onSearch;
  final void Function(GBSearchData place) onNewSearch;

  /// Language used for the autocompletion.
  ///
  /// Check the full list of [supported languages](https://developers.google.com/maps/faq#languagesupport) for the Google Maps API
  final String language;

  /// The point around which you wish to retrieve place information.
  ///
  /// If this value is provided, `radius` must be provided aswell.
  final LatLng? location;

  /// The distance (in meters) within which to return place results. Note that setting a radius biases results to the indicated area, but may not fully restrict results to the specified area.
  ///
  /// If this value is provided, `location` must be provided aswell.
  ///
  /// See [Location Biasing and Location Restrict](https://developers.google.com/places/web-service/autocomplete#location_biasing) in the documentation.
  final int? radius;

  /// Returns only those places that are strictly within the region defined by location and radius. This is a restriction, rather than a bias, meaning that results outside this region will not be returned even if they match the user input.
  final bool? strictBounds;

  /// Place type to filter the search. This is a tool that can be used if you only want to search for a specific type of location. If this no place type is provided, all types of places are searched. For more info on location types, check https://developers.google.com/places/web-service/autocomplete?#place_types
  final PlaceType? placeType;
  final String? newPlaceType;

  /// The initial icon to show in the search box
  final IconData? icon;

  /// Makes available "clear textfield" button when the user is writing.
  final bool? hasClearButton;

  /// The icon to show indicating the "clear textfield" button
  final IconData? clearIcon;

  /// The color of the icon to show in the search box
  final Color? iconColor;

  /// Enables Dark Mode when set to `true`. Default value is `false`.
  final bool? darkMode;
  final EdgeInsetsGeometry outerMarginOfSearchTextField;

  @override
  _SearchMapPlaceWidgetState createState() => _SearchMapPlaceWidgetState();
}

class _SearchMapPlaceWidgetState extends State<SearchGooglePlacesWidget>
    with TickerProviderStateMixin {
  TextEditingController _textEditingController = TextEditingController();
  AnimationController? _animationController;
  // SearchContainer height.
  Animation? _containerHeight;
  // Place options opacity.
  Animation? _listOpacity;

  List<dynamic> _placePredictions = [];
  bool _isEditing = false;
  Geocoding? geocode;

  String _tempInput = "";
  String _currentInput = "";

  FocusNode _fn = FocusNode();

  CrossFadeState? _crossFadeState;
  List<GBSearchData> _placePredictionsData = [];

  @override
  void initState() {
    geocode = Geocoding(apiKey: widget.apiKey, language: widget.language);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _containerHeight = Tween<double>(begin: 60, end: 364).animate(
      CurvedAnimation(
        curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
        parent: _animationController!,
      ),
    );
    _listOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
        parent: _animationController!,
      ),
    );

    _textEditingController.addListener(_autocompletePlace);
    customListener();

    if (widget.hasClearButton!) {
      _fn.addListener(() async {
        if (_fn.hasFocus)
          setState(() => _crossFadeState = CrossFadeState.showSecond);
        else
          setState(() => _crossFadeState = CrossFadeState.showFirst);
      });
      _crossFadeState = CrossFadeState.showFirst;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: context.width,
        margin: widget.outerMarginOfSearchTextField,
        child: _searchContainer(
          child: _searchInput(context),
        ),
      );

  /*
  WIDGETS
  */
  Widget _searchContainer({Widget? child}) {
    return AnimatedBuilder(
        animation: _animationController!,
        builder: (context, _) {
          return SizedBox(
            height: _containerHeight!.value,
            //decoration: _containerDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 16.0, end: 16.0, top: 6, bottom: 4),
                  child: child,
                ),

                /*if (_placePredictions.length > 0)
                  Opacity(
                    opacity: _listOpacity!.value,
                    child: Column(
                      children: <Widget>[
                        for (var prediction in _placePredictions)
                          _placeOption(Place.fromJSON(prediction, geocode)),
                      ],
                    ),
                  ),*/
                //_placePredictionsData
                if (_placePredictionsData.length > 0)
                  Flexible(
                    child: Opacity(
                      opacity: _listOpacity!.value,
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          for (var prediction in _placePredictionsData)
                            _newPlaceOption(prediction),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }

  Widget _searchInput(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: _inputStyle(),
              controller: _textEditingController,
              onSubmitted: (_) => _newSelectPlace(),
              onEditingComplete: _newSelectPlace,
              autofocus: false,
              focusNode: _fn,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: widget.darkMode! ? Colors.grey[100] : Colors.grey[850],
              ),
            ),
          ),
          SizedBox(width: 12),
          if (widget.hasClearButton!)
            GestureDetector(
              onTap: () {
                if (_crossFadeState == CrossFadeState.showSecond)
                  _textEditingController.clear();
              },
              // child: Icon(_inputIcon, color: this.widget.iconColor),
              child: AnimatedCrossFade(
                crossFadeState: _crossFadeState!,
                duration: Duration(milliseconds: 300),
                firstChild: Icon(widget.icon, color: widget.iconColor),
                secondChild: Icon(Icons.clear, color: widget.iconColor),
              ),
            ),
          if (!widget.hasClearButton!)
            Icon(widget.icon, color: widget.iconColor)
        ],
      ),
    );
  }

  Widget _placeOption(Place prediction) {
    String? place = prediction.description;

    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      onPressed: () => _selectPlace(prediction: prediction),
      child: ListTile(
        title: Text(
          place!.length < 45
              ? "$place"
              : "${place.replaceRange(45, place.length, "")} ...",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: widget.darkMode! ? Colors.grey[100] : Colors.grey[850],
          ),
          maxLines: 1,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 0,
        ),
      ),
    );
  }

  Widget _newPlaceOption(GBSearchData prediction) {
    String? place = prediction.displayName;

    return ListTileTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      //minVerticalPadding: 2,
      horizontalTitleGap: 0,
      child: ListTile(
        title: Text(
          place!.length < 45
              ? "$place"
              : "${place.replaceRange(45, place.length, "")} ...",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: widget.darkMode! ? Colors.grey[100] : Colors.grey[850],
          ),
          maxLines: 1,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 0,
        ),
        visualDensity: VisualDensity(vertical: -2),
        onTap: () => _newSelectPlace(prediction: prediction),
      ),
    );
  }

  /*
  STYLING
  */
  InputDecoration _inputStyle() {
    return InputDecoration(
      hintText: this.widget.placeholder,
      border: InputBorder.none,
      //isDense: true,
      contentPadding:
          EdgeInsetsDirectional.symmetric(horizontal: 12.0, vertical: 8.0),
      hintStyle: TextStyle(
        color: widget.darkMode! ? Colors.grey[100] : Colors.grey[850],
      ),
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: widget.darkMode! ? Colors.grey[800] : Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 10)
      ],
    );
  }

  /*
  METHODS
  */

  /// Will be called everytime the input changes. Making callbacks to the Places
  /// Api and giving the user Place options
  void _autocompletePlace() async {
    if (_fn.hasFocus) {
      setState(() {
        _currentInput = _textEditingController.text;
        _isEditing = true;
      });

      _textEditingController.removeListener(_autocompletePlace);

      if (_currentInput.length == 0) {
        if (!_containerHeight!.isDismissed) _closeSearch();
        _textEditingController.addListener(_autocompletePlace);
        return;
      }

      if (_currentInput == _tempInput) {
        //final predictions = await _makeRequest(_currentInput);
        final List<GBSearchData> data =
            await _searchLocationQuery(_currentInput);
        await _animationController!.animateTo(0.5);
        //_placePredictionsData
        setState(() {
          //_placePredictions = predictions;
          _placePredictionsData = data;
        });
        await _animationController!.forward();

        _textEditingController.addListener(_autocompletePlace);
        return;
      }

      Future.delayed(Duration(milliseconds: 500), () {
        _textEditingController.addListener(_autocompletePlace);
        if (_isEditing == true) _autocompletePlace();
      });
    }
  }

  /// API request function. Returns the Predictions
  Future<dynamic> _makeRequest(input) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${widget.apiKey}&language=${widget.language}";
    if (widget.location != null && widget.radius != null) {
      url +=
          "&location=${widget.location!.latitude},${widget.location!.longitude}&radius=${widget.radius}";
      if (widget.strictBounds!) {
        url += "&strictbounds";
      }
      if (widget.placeType != null) {
        url += "&types=${widget.placeType!.apiString}";
      }
    }

    final response = await http.get(Uri.parse(url));
    final json = JSON.jsonDecode(response.body);

    if (json["error_message"] != null) {
      var error = json["error_message"];
      if (error == "This API project is not authorized to use this API.")
        error +=
            " Make sure the Places API is activated on your Google Cloud Platform";
      throw Exception(error);
    } else {
      final predictions = json["predictions"];
      return predictions;
    }
  }

  /// Will be called when a user selects one of the Place options
  void _selectPlace({Place? prediction}) async {
    if (prediction != null) {
      _textEditingController.value = TextEditingValue(
        text: prediction.description!,
        selection: TextSelection.collapsed(
          offset: prediction.description!.length,
        ),
      );
    } else {
      await Future.delayed(Duration(milliseconds: 500));
    }

    // Makes animation
    _closeSearch();

    // Calls the `onSelected` callback
    if (prediction is Place) widget.onSelected(prediction);
  }

  /// Will be called when a user selects one of the Place options
  void _newSelectPlace({GBSearchData? prediction}) async {
    if (prediction != null) {
      _textEditingController.value = TextEditingValue(
        text: prediction.displayName!,
        selection: TextSelection.collapsed(
          offset: prediction.displayName!.length,
        ),
      );
    } else {
      await Future.delayed(Duration(milliseconds: 500));
    }

    // Makes animation
    _closeSearch();

    // Calls the `onSelected` callback
    if (prediction is GBSearchData) widget.onNewSelected(prediction);
  }

  /// Closes the expanded search box with predictions
  void _closeSearch() async {
    if (!_animationController!.isDismissed)
      await _animationController!.animateTo(0.5);
    _fn.unfocus();
    setState(() {
      _placePredictions = [];
      _isEditing = false;
    });
    _animationController!.reverse();
    _textEditingController.addListener(_autocompletePlace);
  }

  /// Will listen for input changes every 0.5 seconds, allowing us to make API requests only when the user stops typing.
  void customListener() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _tempInput = _textEditingController.text);
      }
      customListener();
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _textEditingController.dispose();
    _fn.dispose();
    super.dispose();
  }

  Future<List<GBSearchData>> _searchLocationQuery(String query) async {
    List<GBSearchData> data = await GeocoderBuddy.query(query);
    return data;
  }
}

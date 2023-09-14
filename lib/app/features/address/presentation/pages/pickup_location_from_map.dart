part of 'package:homemakers_merchant/app/features/address/index.dart';

class PickupLocationFromMapPage extends StatefulWidget {
  const PickupLocationFromMapPage({
    super.key,
    this.addressModel,
    this.currentIndex = -1,
    this.hasNewAddress = true,
    this.allAddress = const [],
  });

  final AddressModel? addressModel;
  final int currentIndex;
  final bool hasNewAddress;
  final List<AddressModel> allAddress;

  @override
  _AddressPageController createState() => _AddressPageController();
}

class _AddressPageController extends State<PickupLocationFromMapPage> {
  final ScrollController scrollController = ScrollController();
  Completer<GoogleMapController> mapcontroller = Completer();

  //Set<Marker> markers = {};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late LatLng defaultLatLng;
  late LatLng getCurrentUserLatlng;
  late CameraPosition cameraPosition;
  String markedIdOfCurrentUser = "current_user_location_marker_id";
  double zoomLevel = 19.0;
  late GoogleMapController controller;

  /// Overlay to display autocomplete suggestions
  OverlayEntry? overlayEntry;

  /// Location
  bool _serviceEnabled = true;
  bool _networkEnabled = true;
  loc.PermissionStatus _permissionGranted = loc.PermissionStatus.granted;
  bool _loading = false;
  String? _error;
  GBData? locationAddressData;
  List<Placemark> listOfPlaceMark = [];
  String displayName = '';
  bool isCameraMoving = false;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  loc.Location location = loc.Location();
  AddressModel? addressModel;

  @override
  void initState() {
    super.initState();
    context.read<PermissionBloc>().add(const RequestLocationServiceEnable());
    defaultLatLng = LatLng(23.6724831, 86.817716);
    getCurrentUserLatlng = defaultLatLng;
    cameraPosition = CameraPosition(
      target: defaultLatLng,
      zoom: zoomLevel,
    );
    // Check Permission and Get Current Location
    _initData().then((value) async {
      controller = await mapcontroller.future;
      await controller.animateCamera(CameraUpdate.newLatLngZoom(value, zoomLevel));
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: value,
          zoom: zoomLevel,
        )),
      );
      await setMarker(value);
      await fetchAddressDetails(value);
      return;
    });
    setMarker(defaultLatLng);
    fetchAddressDetails(defaultLatLng);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void dispose() {
    overlayEntry?.remove();
    if(!mounted || mounted) {
      controller.dispose();
      mapcontroller.complete(controller);
    }
    super.dispose();
  }

  Future<LatLng> _initData() async {
    if (widget.addressModel != null) {
      appLog.d('IF');
      final sharedAddressModel = widget.addressModel as AddressModel?;
      addressModel = sharedAddressModel;
      defaultLatLng = LatLng(addressModel?.address?.latitude ?? defaultLatLng.latitude, addressModel?.address?.longitude ?? defaultLatLng.longitude);
      getCurrentUserLatlng = defaultLatLng;
      return defaultLatLng;
    } else {
      appLog.d('ELSE 0.0 ${defaultLatLng}, ${getCurrentUserLatlng}');
      await fetchUserLocation().whenComplete(() => defaultLatLng = getCurrentUserLatlng);
      appLog.d('ELSE 1.0 ${defaultLatLng}, ${getCurrentUserLatlng}');
      return defaultLatLng;
    }
    appLog.d('OUTSIDE ELSE ${defaultLatLng}, ${getCurrentUserLatlng}');
    return defaultLatLng;
  }

  void mapCreated(GoogleMapController controller) {
    if (mapcontroller.isCompleted) {
    } else {
      mapcontroller.complete(controller);
    }
    _initData();
    return;
  }

  void onSelected(Place place) async {
    final geolocation = await place.geolocation;

    // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
    final GoogleMapController controller = await mapcontroller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(geolocation!.coordinates, zoomLevel));
    controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: geolocation!.coordinates,
        zoom: zoomLevel,
      )),
    );
    //update();
    return;
  }

  Future<void> onCameraMove(CameraPosition cameraPositiona) async {
    cameraPosition = cameraPositiona;
    //zoomLevel = cameraPositiona.zoom;
    //defaultLatLng = cameraPositiona.target;
    /*GoogleMapController controller = await mapcontroller.future;
    controller.animateCamera(CameraUpdate.newLatLng(cameraPositiona.target));
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: cameraPositiona.target,
        zoom: cameraPositiona.zoom,
      )),
    );*/
    /*setMarker(
      defaultLatLng,
    );
    fetchAddressDetails(defaultLatLng);*/
/*    await setMarker(
      defaultLatLng,
    );
    await fetchAddressDetails(defaultLatLng);*/
    setState(() {});
    return;
  }

  void onCameraMoveStarted() {
    return;
  }

  Future<void> onCameraIdle() async {
    final GoogleMapController mapController = await mapcontroller.future;
    var defaultZoom = await mapController.getZoomLevel();
    LatLngBounds bounds = await mapController.getVisibleRegion();
    final longitude = (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
    final latitude = (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
    //mapController.animateCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));
    LatLng latLng = LatLng(latitude, longitude);
    mapController.animateCamera(CameraUpdate.newLatLngZoom(
      defaultLatLng,
      zoomLevel,
    ));
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: defaultLatLng,
        zoom: zoomLevel,
      )),
    );

    /*this._memoizer.runOnce(() async {
      await setMarker(
        latLng,
      );
      await fetchAddressDetails(latLng);
    });*/

    setState(() {});
    return;
  }

  /// Hides the autocomplete overlay
  void clearOverlay() {
    if (this.overlayEntry != null) {
      this.overlayEntry?.remove();
      this.overlayEntry = null;
      setState(() {});
    }
    return;
  }

  /// Moves the marker to the indicated lat,lng
  Future<void> setMarker(LatLng latLng) async {
    final _marker = markers.values.toList().firstWhere(
          (item) => item.markerId == markedIdOfCurrentUser,
          orElse: () => Marker(markerId: MarkerId(markedIdOfCurrentUser)),
        );
    final currentUserMarker = RippleMarker(
      markerId: MarkerId(markedIdOfCurrentUser),
      position: LatLng(latLng.latitude, latLng.longitude),
      draggable: true,
      visible: true,
      ripple: true,
      onDragEnd: (LatLng value) async {
        defaultLatLng = value;
        await setMarker(value);
        await fetchAddressDetails(value);
      },
      infoWindow: const InfoWindow(
        title: 'Your Order will be delivered here',
        snippet: 'Place the pin to your exact location',
      ),
    );
    markers.removeWhere((key, value) => value.markerId.value == markedIdOfCurrentUser);
    markers[MarkerId(markedIdOfCurrentUser)] = currentUserMarker;
    GoogleMapController controller = await mapcontroller.future;
    await controller.showMarkerInfoWindow(MarkerId(markedIdOfCurrentUser));
    //defaultLatLng = latLng;
    //fetchAddressDetails(latLng);
    setState(() {});
    return;
  }

  Future<void> fetchAddressDetails(LatLng latLng) async {
    appLog.i('fetchAddressDetails defaultLatLng - ${latLng.toJson()}');
    String placeMarkDisplayName = '';
    GBData data = await GeocoderBuddy.findDetails(GBLatLng(lat: latLng.latitude, lng: latLng.longitude));
    locationAddressData = GBData.fromJson(data.toJson());
    if (locationAddressData != null && locationAddressData?.displayName != null && locationAddressData?.address != null) {
      placeMarkDisplayName = locationAddressData?.displayName ?? 'Please wait...';
      appLog.i("placeMarkDisplayName 1 - ${placeMarkDisplayName}");
    } else {
      List<Placemark> listOfPlaceMark = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      this.listOfPlaceMark.clear();
      this.listOfPlaceMark = [];
      this.listOfPlaceMark = List<Placemark>.from(listOfPlaceMark.toList());
      if (this.listOfPlaceMark.isNotEmpty) {
        placeMarkDisplayName = this.listOfPlaceMark[0].name ?? 'Please wait...';
        appLog.i("placeMarkDisplayName 2 - ${placeMarkDisplayName}");
      }
    }
    displayName = placeMarkDisplayName;
    appLog.i("placeMarkDisplayName 3 - ${displayName}");
    appLog.i("fetchAddressDetails - ${locationAddressData?.toJson()}");

    setState(() {});
    return;
  }

  /// Moves the camera to the provided location and updates other UI features to
  /// match the location.
  Future<void> moveToLocation(LatLng latLng) async {
    GoogleMapController controller = await mapcontroller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(
      latLng,
      zoomLevel,
    ));
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: latLng,
        zoom: zoomLevel,
      )),
    );
    return;
  }

  Future<void> onTapOnMap(LatLng latLng) async {
    clearOverlay();
    await moveToLocation(latLng);
    await setMarker(latLng);
    await fetchAddressDetails(latLng);
    defaultLatLng = latLng;
    appLog.i("OnTap ${latLng.toJson()} - ${defaultLatLng.toJson()}");
    setState(() {});
    return;
  }

/*  double calculateRotation(LatLng start, LatLng end) {
    double calculatedRotation = geolocator.Geolocator.bearingBetween(
        start.latitude, start.longitude, end.latitude, end.longitude);
    return calculatedRotation;
  }*/

  void navigateToCompleteAddressScreen() {
    context.push(Routes.ADDRESS_FORM_PAGE, extra: {
      'locationData': locationAddressData,
      'latitude': defaultLatLng.latitude,
      'longitude': defaultLatLng.longitude,
      'addressModel': addressModel?.copyWith(
        address: AddressBean(
          latitude: defaultLatLng.latitude,
          longitude: defaultLatLng.longitude,
        ),
      ),
      'allAddress': widget.allAddress.toList(),
      'currentIndex': widget.hasNewAddress,
      'hasNewAddress': widget.hasNewAddress,
    });
    return;
  }

  Future<void> fetchUserLocation() async {
    await _checkService();
    //await _checkNetworkService();
    if (_serviceEnabled) {
      await _checkPermissions();
      return;
    } else {
      final bool status = await location.requestService();
      if (status) {
        await fetchUserLocation();
        return;
      } else {
        // location service is not enabled by user
        return;
      }
    }
    setState(() {});
    return;
  }

  Future<void> _checkService() async {
    final serviceEnabledResult = await location.serviceEnabled();
    _serviceEnabled = serviceEnabledResult;
    setState(() {});
    return;
  }

  Future<void> _checkNetworkService() async {
    //final serviceEnabledResult = await isNetworkEnabled();
    //_networkEnabled = serviceEnabledResult;
    //update(['address_list']);
  }

  Future<void> _checkPermissions() async {
    final permissionGrantedResult = await location.hasPermission();
    _permissionGranted = permissionGrantedResult;
    if (_permissionGranted == loc.PermissionStatus.granted || _permissionGranted == loc.PermissionStatus.grantedLimited) {
      await _getLocation();
      GoogleMapController controller = await mapcontroller.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(defaultLatLng, zoomLevel));
      controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: defaultLatLng,
          zoom: zoomLevel,
        )),
      );
      await setMarker(defaultLatLng);
      await fetchAddressDetails(defaultLatLng);
      setState(() {});
      return;
    } else if (_permissionGranted == loc.PermissionStatus.denied) {
      await _requestPermission();
      if (_permissionGranted != loc.PermissionStatus.deniedForever) {
        // Not ask permission
      } else {
        await _checkPermissions();
      }
      setState(() {});
      return;
    }
    setState(() {});
    return;
  }

  Future<void> _requestPermission() async {
    final permissionRequestedResult = await location.requestPermission();
    _permissionGranted = permissionRequestedResult;
    setState(() {});
    return;
  }

  Future<void> _getLocation() async {
    _error = null;
    _loading = true;
    var latitude = 0.0;
    var longitude = 0.0;
    try {
      /*loc.LocationData _locationResult = await location.getLocation();
      await Future.delayed(const Duration(seconds: 5));
      if (_locationResult != null) {
        latitude = _locationResult.latitude ?? 0;
        longitude = _locationResult.longitude ?? 0;
      } else {
        geolocator.Position position =
            await geolocator.Geolocator.getCurrentPosition();
        latitude = position.latitude;
        longitude = position.longitude;
      }*/
/*      geolocator.Position position =
      await geolocator.Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;*/
      loc.LocationData _locationResult = await location.getLocation();
      await Future.delayed(const Duration(seconds: 1), () {});
      latitude = _locationResult.latitude ?? 0;
      longitude = _locationResult.longitude ?? 0;
      getCurrentUserLatlng = LatLng(latitude, longitude);
      defaultLatLng = getCurrentUserLatlng;
      debugPrint("Location - ${defaultLatLng.toJson()}- ${getCurrentUserLatlng.toJson()}");
      _loading = false;
      setState(() {});

      //await setMarker(defaultLatLng);
      //await fetchAddressDetails(defaultLatLng);
    } on PlatformException catch (err) {
      _error = err.code;
      _loading = false;
    }
    return;
  }

  void onNewSearch(GBSearchData place) {}

  Future<void> onNewSelected(GBSearchData data) async {
    defaultLatLng = LatLng(double.parse(data.lat), double.parse(data.lon));
    GoogleMapController controller = await mapcontroller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(defaultLatLng, zoomLevel));
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: defaultLatLng,
        zoom: zoomLevel,
      )),
    );
    await setMarker(defaultLatLng);
    await fetchAddressDetails(defaultLatLng);
    return;
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<PermissionBloc, PermissionState>(
        bloc: context.read<PermissionBloc>(),
        buildWhen: (previous, current) => previous != current,
        builder: (context, permissionState) {
          switch (permissionState) {
            case PermissionStateGranted():
              {
                getCurrentUserLatlng = LatLng(permissionState.latitude, permissionState.longitude);
                defaultLatLng = getCurrentUserLatlng;
              }
            case PermissionStateDenied():
              {}
            case PermissionStateError():
              {}
            case PermissionStatePermanentlyDenied():
              {}
            case PermissionStateLimited():
              {}
            case PermissionStateRestricted():
              {}
            case PermissionServiceNotEnableByUser():
              {}
          }
          return _AddressPageView(this);
        },
      );
}

class _AddressPageView extends WidgetView<PickupLocationFromMapPage, _AddressPageController> {
  const _AddressPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('address-page-slideInLeft-widget'),
            delay: const Duration(milliseconds: 500),
            child: PageBody(
              controller: state.scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                top: 0,
              ),
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    maxHeight: media.size.height - (media.padding.top + kToolbarHeight + media.padding.bottom),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            Animarker(
                              curve: Curves.ease,
                              mapId: state.mapcontroller.future.then<int>((value) => value.mapId),
                              //Grab Google Map Id
                              markers: state.markers.values.toSet(),
                              rippleRadius: 0.12,
                              rippleColor: Colors.teal,
                              rippleDuration: Duration(milliseconds: 2500),
                              useRotation: false,
                              shouldAnimateCamera: true,
                              key: Key(state.markedIdOfCurrentUser),
                              child: GoogleMap(
                                scrollGesturesEnabled: true,
                                initialCameraPosition: state.cameraPosition!,
                                onMapCreated: state.mapCreated,
                                //onCameraMoveStarted: state.onCameraMoveStarted,
                                //onCameraIdle: state.onCameraIdle,
                                onCameraMove: state.onCameraMove,
                                //minMaxZoomPreference: MinMaxZoomPreference(14, 100),
                                tiltGesturesEnabled: true,
                                rotateGesturesEnabled: true,
                                onTap: state.onTapOnMap,
                                zoomGesturesEnabled: true,
                                zoomControlsEnabled: true,
                                gestureRecognizers: Set()
                                  ..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()))
                                  ..add(
                                    Factory<OneSequenceGestureRecognizer>(
                                      () => new EagerGestureRecognizer(),
                                    ),
                                  ),
                                key: const Key('address-picker-map'),
                              ),
                            ),
                            PositionedDirectional(
                              top: 0,
                              start: 0,
                              end: 0,
                              child: Container(
                                child: SearchGooglePlacesWidget(
                                    apiKey: 'AIzaSyB6wUuIm0xLJbTFm6qPiwKgULJupJ8IE8s',
                                    // The language of the autocompletion
                                    language: 'en',
                                    // The position used to give better recommendations. In this case we are using the user position
                                    radius: 30000,
                                    location: state.defaultLatLng,
                                    onSelected: state.onSelected,
                                    onSearch: (Place place) {},
                                    onNewSearch: state.onNewSearch,
                                    onNewSelected: state.onNewSelected,
                                    outerMarginOfSearchTextField: EdgeInsetsDirectional.only(start: margins, end: margins)),
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 0,
                              end: margins * 2.5,
                              start: margins * 2.5,
                              child: OutlinedButton.icon(
                                onPressed: () async {
                                  await state.fetchUserLocation();
                                  return;
                                },
                                icon: Icon(Icons.gps_fixed_outlined),
                                label: Text(
                                  'Use current location',
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const AnimatedGap(12, duration: Duration(milliseconds: 100)),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          //bottom: bottomPadding - margins,
                          start: margins * 2.5,
                          end: margins * 2.5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Your location',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                            const AnimatedGap(6, duration: Duration(milliseconds: 100)),
                            Flexible(
                              child: Wrap(
                                children: [
                                  Text(
                                    '${state.displayName}',
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                ],
                              ),
                            ),
                            const AnimatedGap(6, duration: Duration(milliseconds: 100)),
                          ],
                        ),
                      )),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          //bottom: bottomPadding - margins,
                          start: margins * 2.5,
                          end: margins * 2.5,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            await context.push(Routes.ADDRESS_FORM_PAGE, extra: {
                              'locationData': state.locationAddressData,
                              'latitude': state.defaultLatLng.latitude,
                              'longitude': state.defaultLatLng.longitude,
                              'addressModel': state.addressModel?.copyWith(
                                address: AddressBean(
                                  latitude: state.defaultLatLng.latitude,
                                  longitude: state.defaultLatLng.longitude,
                                ),
                              ),
                              'allAddress': widget.allAddress.toList(),
                              'currentIndex': widget.currentIndex,
                              'hasNewAddress': widget.hasNewAddress,
                              'hasViewAddress': false,
                            });
                            return;
                          },
                          child: Text(
                            'Confirm Location',
                            style: context.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                          ).translate(),
                          style: ElevatedButton.styleFrom(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

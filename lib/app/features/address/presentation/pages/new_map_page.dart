part of 'package:homemakers_merchant/app/features/address/index.dart';

class NewMapPage extends StatefulWidget {
  const NewMapPage({super.key});

  @override
  _NewMapPageController createState() => _NewMapPageController();
}

class _NewMapPageController extends State<NewMapPage>
    with TickerProviderStateMixin {
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;
  late final mapBox.MapController mapController;
  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';
  latlng2.LatLng london = latlng2.LatLng(51.5, -0.09);
  latlng2.LatLng paris = latlng2.LatLng(48.8566, 2.3522);
  latlng2.LatLng dublin = latlng2.LatLng(53.3498, -6.2603);
  var markers = <mapBox.Marker>[
    mapBox.Marker(
      width: 20,
      height: 20,
      point: latlng2.LatLng(51.5, -0.09),
      child: FlutterLogo(key: ValueKey('blue')),
    ),
    mapBox.Marker(
      width: 20,
      height: 20,
      point: latlng2.LatLng(53.3498, -6.2603),
      child: FlutterLogo(key: ValueKey('green')),
    ),
    mapBox.Marker(
      width: 20,
      height: 20,
      point: latlng2.LatLng(48.8566, 2.3522),
      child: FlutterLogo(key: ValueKey('purple')),
    ),
  ];

  @override
  void initState() {
    super.initState();
    mapController = mapBox.MapController();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    customScrollViewScrollController.dispose();
    super.dispose();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final camera = mapController.camera;
    final latTween = Tween<double>(
        begin: camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    // Note this method of encoding the target destination is a workaround.
    // When proper animated movement is supported (see #1263) we should be able
    // to detect an appropriate animated movement event which contains the
    // target zoom/center.
    final startIdWithTarget =
        '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;

    controller.addListener(() {
      final String id;
      if (animation.value == 1.0) {
        id = _finishedId;
      } else if (!hasTriggeredMove) {
        id = startIdWithTarget;
      } else {
        id = _inProgressId;
      }

      hasTriggeredMove |= mapController.move(
        latlng2.LatLng(
            latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
        id: id,
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  final _animatedMoveTileUpdateTransformer =
      mapBox.TileUpdateTransformer.fromHandlers(
          handleData: (updateEvent, sink) {
    final mapEvent = updateEvent.mapEvent;

    final id = mapEvent is mapBox.MapEventMove ? mapEvent.id : null;
    if (id?.startsWith(_NewMapPageController._startedId) == true) {
      final parts = id!.split('#')[2].split(',');
      final lat = double.parse(parts[0]);
      final lon = double.parse(parts[1]);
      final zoom = double.parse(parts[2]);

      // When animated movement starts load tiles at the target location and do
      // not prune. Disabling pruning means existing tiles will remain visible
      // whilst animating.
      sink.add(
        updateEvent.loadOnly(
          loadCenterOverride: latlng2.LatLng(lat, lon),
          loadZoomOverride: zoom,
        ),
      );
    } else if (id == _NewMapPageController._inProgressId) {
      // Do not prune or load whilst animating so that any existing tiles remain
      // visible. A smarter implementation may start pruning once we are close to
      // the target zoom/location.
    } else if (id == _NewMapPageController._finishedId) {
      // We already prefetched the tiles when animation started so just prune.
      sink.add(updateEvent.pruneOnly());
    } else {
      sink.add(updateEvent);
    }
  });

  @override
  Widget build(BuildContext context) => _NewMapPageView(this);
}

class _NewMapPageView extends WidgetView<NewMapPage, _NewMapPageController> {
  const _NewMapPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
            title: const Text('Map'),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () async {
                  final notification = await context.push(Routes.NOTIFICATIONS);
                  return;
                },
                icon: Badge(
                  alignment: AlignmentDirectional.topEnd,
                  //padding: EdgeInsets.all(4),
                  backgroundColor: context.colorScheme.secondary,
                  isLabelVisible: true,
                  largeSize: 16,
                  textStyle: const TextStyle(fontSize: 14),
                  textColor: Colors.yellow,
                  label: Text(
                    '10',
                    style: context.labelSmall!
                        .copyWith(color: context.colorScheme.onPrimary),
                    //Color.fromRGBO(251, 219, 11, 1)
                  ),
                  child: Icon(Icons.notifications,
                      color: context.colorScheme.primary),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('new-map-slideinleft-widget'),
            from: context.width / 2 - 60,
            duration: const Duration(milliseconds: 500),
            child: Directionality(
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              child: PageBody(
                controller: state.scrollController,
                constraints: BoxConstraints(
                  minWidth: 1000,
                  minHeight: media.size.height -
                      (media.padding.top +
                          kToolbarHeight +
                          media.padding.bottom),
                ),
                padding: EdgeInsetsDirectional.only(
                  top: 0,
                  //bottom: bottomPadding,
                  start: 0,
                  end: 0,
                ),
                child: CustomScrollView(
                  controller: state.customScrollViewScrollController,
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: true,
                      child: mapBox.FlutterMap(
                        options: mapBox.MapOptions(
                          minZoom: 5,
                          maxZoom: 18,
                          initialZoom: 5,
                          initialCenter: latlng2.LatLng(51.5, -0.09),
                        ),
                        children: [
                          mapBox.TileLayer(
                            urlTemplate:
                                'https://api.mapbox.com/styles/v1/prasant10050/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                            userAgentPackageName: 'com.homemakers.merchant',
                            tileUpdateTransformer:
                                state._animatedMoveTileUpdateTransformer,
                            additionalOptions: {
                              'mapStyleId': 'clmgpwxia01is01pjgmzx9hmh',
                              'accessToken':
                                  'pk.eyJ1IjoicHJhc2FudDEwMDUwIiwiYSI6ImNqbDZ5YjQzcDFjN3QzcG1xZzJxd21qZWsifQ.HJO13RDtCRYneLun9t2dQA',
                            },
                          ),
                          mapBox.MarkerLayer(markers: state.markers),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

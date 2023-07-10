import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_makers_customer_cli/app/core/commons/base/presentation/presentation.dart';
import 'package:home_makers_customer_cli/app/core/commons/widgets/map/google_map_place/google_map_place.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker_updates.dart';
import 'package:home_makers_customer_cli/app/modules/address/data/models/adddress_model.dart';
import 'package:home_makers_customer_cli/app/modules/address/domain/entities/location/location_permission_state.dart';
import 'package:home_makers_customer_cli/app/routes/app_pages.dart';
import 'package:location/location.dart' as loc;

class AddressListController extends BaseController {
  AddressListController();

  static final LogServiceImpl logService = Get.find();
  Completer<GoogleMapController> mapcontroller = Completer();

  //Set<Marker> markers = {};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late LatLng defaultLatLng;
  late LatLng getCurrentUserLatlng;
  late CameraPosition cameraPosition;
  String markedIdOfCurrentUser = "current_user_location_marker_id";
  double zoomLevel = 19.0;

  /// Overlay to display autocomplete suggestions
  OverlayEntry? overlayEntry;

  /// Location
  bool _serviceEnabled = true;
  bool _networkEnabled = true;
  loc.PermissionStatus _permissionGranted = loc.PermissionStatus.granted;
  bool _loading = false;
  String? _error;
  LocationPermissionState locationPermissionState =
      LocationPermissionState.idle();
  CurrentLocationPermission currentLocationPermission =
      CurrentLocationPermission.bothNetWorkAndGpsEnabled;
  GBData? locationAddressData;
  List<Placemark> listOfPlaceMark = [];
  String displayName = '';
  bool isCameraMoving = false;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  loc.Location location = loc.Location();
  AddressModel? addressModel;

  Future<void> _initData() async {
    if (Get.arguments != null) {
      final sharedAddressModel = Get.arguments as AddressModel?;
      addressModel = sharedAddressModel;
      defaultLatLng = LatLng(
          addressModel?.address?.latitude ?? defaultLatLng.latitude,
          addressModel?.address?.longitude ?? defaultLatLng.longitude);
      getCurrentUserLatlng = defaultLatLng;
    } else {
      await fetchUserLocation();
      defaultLatLng = getCurrentUserLatlng;
    }
    GoogleMapController controller = await mapcontroller.future;
    controller.animateCamera(
        CameraUpdate.newLatLngZoom(getCurrentUserLatlng, zoomLevel));
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: getCurrentUserLatlng,
        zoom: zoomLevel,
      )),
    );
    await setMarker(getCurrentUserLatlng);
    await fetchAddressDetails(getCurrentUserLatlng);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    defaultLatLng = LatLng(24.788137757488556, 46.76468951627612);
    cameraPosition = CameraPosition(
      target: defaultLatLng,
      zoom: zoomLevel,
    );
    setMarker(defaultLatLng);
    fetchAddressDetails(defaultLatLng);
  }

  @override
  void onReady() {
    super.onReady();
  }

  void mapCreated(GoogleMapController controller) {
    if (mapcontroller.isCompleted) {
    } else {
      mapcontroller.complete(controller);
    }
    _initData();
  }

  void onSelected(Place place) async {
    final geolocation = await place.geolocation;

    // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
    final GoogleMapController controller = await mapcontroller.future;
    controller.animateCamera(
        CameraUpdate.newLatLngZoom(geolocation!.coordinates, zoomLevel));
    controller
        .animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: geolocation!.coordinates,
        zoom: zoomLevel,
      )),
    );
    //update();
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

    update(['address_list']);
  }

  void onCameraMoveStarted() {}

  Future<void> onCameraIdle() async {
    final GoogleMapController mapController = await mapcontroller.future;
    var defaultZoom = await mapController.getZoomLevel();
    LatLngBounds bounds = await mapController.getVisibleRegion();
    final longitude =
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
    final latitude =
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
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

    update(['address_list']);
  }

  /// Hides the autocomplete overlay
  void clearOverlay() {
    if (this.overlayEntry != null) {
      this.overlayEntry?.remove();
      this.overlayEntry = null;
      update(['address_list']);
    }
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
      onDragEnd: (value) async {
        defaultLatLng = value;
        await setMarker(value);
        await fetchAddressDetails(value);
      },
      infoWindow: const InfoWindow(
        title: 'Your Order will be delivered here',
        snippet: 'Place the pin to your exact location',
      ),
    );
    markers.removeWhere(
        (key, value) => value.markerId.value == markedIdOfCurrentUser);
    markers[MarkerId(markedIdOfCurrentUser)] = currentUserMarker;
    GoogleMapController controller = await mapcontroller.future;
    await controller.showMarkerInfoWindow(MarkerId(markedIdOfCurrentUser));
    //defaultLatLng = latLng;
    //fetchAddressDetails(latLng);
    update(['address_list']);
  }

  Future<void> fetchAddressDetails(LatLng latLng) async {
    logService.logger
        .i('fetchAddressDetails defaultLatLng - ${latLng.toJson()}');
    String placeMarkDisplayName = '';
    GBData data = await GeocoderBuddy.findDetails(
        GBLatLng(lat: latLng.latitude, lng: latLng.longitude));
    locationAddressData = GBData.fromJson(data.toJson());
    if (locationAddressData != null &&
        locationAddressData?.displayName != null &&
        locationAddressData?.address != null) {
      placeMarkDisplayName =
          locationAddressData?.displayName ?? 'Please wait...';
      logService.logger.i("placeMarkDisplayName 1 - ${placeMarkDisplayName}");
    } else {
      List<Placemark> listOfPlaceMark =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      this.listOfPlaceMark.clear();
      this.listOfPlaceMark = [];
      this.listOfPlaceMark = List<Placemark>.from(listOfPlaceMark.toList());
      if (this.listOfPlaceMark.isNotEmpty) {
        placeMarkDisplayName = this.listOfPlaceMark[0].name ?? 'Please wait...';
        logService.logger.i("placeMarkDisplayName 2 - ${placeMarkDisplayName}");
      }
    }
    displayName = placeMarkDisplayName;
    logService.logger.i("placeMarkDisplayName 3 - ${displayName}");
    logService.logger
        .i("fetchAddressDetails - ${locationAddressData?.toJson()}");

    update(['address_list']);
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
  }

  Future<void> onTapOnMap(LatLng latLng) async {
    clearOverlay();
    await moveToLocation(latLng);
    await setMarker(latLng);
    await fetchAddressDetails(latLng);
    defaultLatLng = latLng;
    logService.logger.i("OnTap ${latLng.toJson()} - ${defaultLatLng.toJson()}");
    update(['address_list']);
  }

  @override
  void onClose() {
    this.overlayEntry?.remove();
    super.onClose();
  }

  double calculateRotation(LatLng start, LatLng end) {
    double calculatedRotation = geolocator.Geolocator.bearingBetween(
        start.latitude, start.longitude, end.latitude, end.longitude);
    return calculatedRotation;
  }

  void navigateToCompleteAddressScreen() {
    Get.toNamed(Routes.DELIVERY_ADDRESS, arguments: {
      'locationData': locationAddressData,
      'latitude': defaultLatLng.latitude,
      'longitude': defaultLatLng.longitude,
      'addressModel': addressModel,
    });
    return;
  }

  Future<void> fetchUserLocation() async {
    await _checkService();
    //await _checkNetworkService();
    if (_serviceEnabled) {
      await _checkPermissions();
    } else {
      final bool status = await location.requestService();
      if (status) {
        fetchUserLocation();
      } else {
        // location service is not enabled by user
        return;
      }
    }
    update(['address_list']);
  }

  Future<void> _checkService() async {
    final serviceEnabledResult = await location.serviceEnabled();
    _serviceEnabled = serviceEnabledResult;
    update(['address_list']);
  }

  Future<void> _checkNetworkService() async {
    //final serviceEnabledResult = await isNetworkEnabled();
    //_networkEnabled = serviceEnabledResult;
    //update(['address_list']);
  }

  Future<void> _checkPermissions() async {
    final permissionGrantedResult = await location.hasPermission();
    _permissionGranted = permissionGrantedResult;
    if (_permissionGranted == loc.PermissionStatus.granted ||
        _permissionGranted == loc.PermissionStatus.grantedLimited) {
      await _getLocation();
      GoogleMapController controller = await mapcontroller.future;
      controller
          .animateCamera(CameraUpdate.newLatLngZoom(defaultLatLng, zoomLevel));
      controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: defaultLatLng,
          zoom: zoomLevel,
        )),
      );
      await setMarker(defaultLatLng);
      await fetchAddressDetails(defaultLatLng);
    } else if (_permissionGranted == loc.PermissionStatus.denied) {
      await _requestPermission();
      if (_permissionGranted != loc.PermissionStatus.deniedForever) {
        // Not ask permission
      } else {
        await _checkPermissions();
      }
    }
    update(['address_list']);
  }

  Future<void> _requestPermission() async {
    final permissionRequestedResult = await location.requestPermission();
    _permissionGranted = permissionRequestedResult;
    update(['address_list']);
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
      geolocator.Position position =
          await geolocator.Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;
      getCurrentUserLatlng = LatLng(latitude, longitude);
      defaultLatLng = getCurrentUserLatlng;
      debugPrint(
          "Location - ${defaultLatLng.toJson()}- ${getCurrentUserLatlng.toJson()}");
      _loading = false;

      //await setMarker(defaultLatLng);
      //await fetchAddressDetails(defaultLatLng);
    } on PlatformException catch (err) {
      _error = err.code;
      _loading = false;
    }
    update(['address_list']);
  }

  void onNewSearch(GBSearchData place) {}

  Future<void> onNewSelected(GBSearchData data) async {
    defaultLatLng = LatLng(double.parse(data.lat), double.parse(data.lon));
    GoogleMapController controller = await mapcontroller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(defaultLatLng, zoomLevel));
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: defaultLatLng,
        zoom: zoomLevel,
      )),
    );
    await setMarker(defaultLatLng);
    await fetchAddressDetails(defaultLatLng);
  }

  Future<void> getLocationPermissionState(
      LocationPermissionState currentLocationPermissionState) async {
    locationPermissionState.when(
      idle: (currentLocationPermission) {
        this.currentLocationPermission = currentLocationPermission;
      },
      gpsEnable: (currentLocationPermission, reason) {
        this.currentLocationPermission = currentLocationPermission;
      },
      statusOfGpsAndNetwork: (currentLocationPermission, reason) {
        this.currentLocationPermission = currentLocationPermission;
      },
      networkEnable: (currentLocationPermission, reason) {
        this.currentLocationPermission = currentLocationPermission;
      },
      notDetermined: (reason, permissionStatus, currentLocationPermission) {
        this.currentLocationPermission = currentLocationPermission;
      },
      restricted: (reason, permissionStatus, currentLocationPermission) {
        this.currentLocationPermission = currentLocationPermission;
      },
      authorizedAlways: (data, permissionStatus, currentLocationPermission) {
        this.currentLocationPermission = currentLocationPermission;
      },
      authorizedWhenInUse: (data, permissionStatus, currentLocationPermission) {
        this.currentLocationPermission = currentLocationPermission;
      },
      denied: (reason, permissionStatus, currentLocationPermission) {
        this.currentLocationPermission = currentLocationPermission;
      },
      error: (reason, permissionStatus, currentLocationPermission, error,
          networkException, stackTrace) {
        this.currentLocationPermission = currentLocationPermission;
      },
    );
    update(['address_list']);
  }

  void backButton() {
    Get.close(1);
  }

  /// Create a position stream which is used as default value of
  /// [CurrentLocationLayer.positionStream].
/*Stream<LocationPermissionState?> defaultPositionStreamSource() {
    final streamController = StreamController<LocationPermissionState?>();
    Future.microtask(() async {
      try {
        await _checkService();
        await _checkNetworkService();
        if (_serviceEnabled && _networkEnabled) {}
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          streamController.sink
              .addError(const lm.PermissionRequestingException());
          permission = await Geolocator.requestPermission();
        }
        switch (permission) {
          case LocationPermission.denied:
          case LocationPermission.deniedForever:
            streamController.sink
                .addError(const lm.PermissionDeniedException());
            break;
          case LocationPermission.whileInUse:
          case LocationPermission.always:
            try {
              final lastKnown = await Geolocator.getLastKnownPosition();
              if (lastKnown != null) {
                streamController.sink.add(lastKnown);
              }
            } catch (_) {}
            streamController.sink.addStream(Geolocator.getPositionStream());
            break;
          case LocationPermission.unableToDetermine:
            break;
        }
      } on PermissionDefinitionsNotFoundException {
        streamController.sink.addError(const IncorrectSetupException());
      }
    });
    return streamController.stream;
  }*/
}

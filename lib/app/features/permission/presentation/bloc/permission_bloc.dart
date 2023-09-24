import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
import 'package:location/location.dart' as loc;

part 'permission_event.dart';

part 'permission_state.dart';

part 'permission_bloc.freezed.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  loc.Location location = loc.Location();

  PermissionBloc() : super(const PermissionState.initial()) {
    on<RequestPermissionEvent>(_requestPermissionEvent);
    on<RequestAllPermissionEvent>(_requestAllPermissionEvent);
    on<RequestLocationPermissionEvent>(_requestLocationPermissionEvent);
    on<RequestLocationServiceEnable>(_requestLocationServiceEnable);
  }

  FutureOr<void> _requestPermissionEvent(
    RequestPermissionEvent event,
    Emitter<PermissionState> emit,
  ) async {
    try {
      var permissions = <Permission, PermissionStatus>{};
      if (await event.permission.isGranted ||
          await event.permission.isLimited) {
        permissions[event.permission] = PermissionStatus.granted;
        //
        if (permissions[event.permission] == PermissionStatus.granted) {
          emit(
            const PermissionStateGranted(
              message: 'Permission is granted by you',
            ),
          );
        } else {
          emit(
            const PermissionStateLimited(
              message: 'Permission is granted by you',
            ),
          );
        }
      } else {
        final requestStatus = await event.permission.request();
        if (requestStatus == PermissionStatus.granted ||
            requestStatus == PermissionStatus.limited) {
          //
          add(RequestPermissionEvent(
            event.permission,
          ));
        } else if (requestStatus == PermissionStatus.denied) {
          //
          emit(
            const PermissionStateDenied(
              message:
                  'Permission is denied by you. Please grant the permission either re-request the permssion or from the app settings.',
            ),
          );
        } else {
          // Open setting
          emit(
            const PermissionStatePermanentlyDenied(
              message:
                  'Permission is permanently denied by you. Please grant the permission from app settings.',
            ),
          );
          await AppSettings.openAppSettings();
        }
      }
    } catch (e) {
      emit(
        PermissionStateError(
          error: 'Permission error: $e',
        ),
      );
    }
  }

  FutureOr<void> _requestAllPermissionEvent(
    RequestAllPermissionEvent event,
    Emitter<PermissionState> emit,
  ) {}

  FutureOr<void> _requestLocationPermissionEvent(
    RequestLocationPermissionEvent event,
    Emitter<PermissionState> emit,
  ) async {
    try {
      var permissions = <Permission, PermissionStatus>{};

      // Check location service is enabled
      if (await Permission.location.serviceStatus.isEnabled) {
        // Service is enabled
        final status = await Permission.locationAlways.request();
        permissions[event.permission] = status;
        if (status.isGranted || status.isLimited) {
          // Location permission is granted or limited use
          // Get user location
          return await _getCurrentUserLocation(event, emit);
        } else if (status.isDenied) {
          // Location permission is not granted
          final status = await Permission.locationWhenInUse.request();
          permissions[event.permission] = status;
          if (status.isGranted || status.isLimited) {
            // Location permission is granted or limited use
            // Get user location
            return await _getCurrentUserLocation(event, emit);
          } else {
            // Permission is permanently denied
            add(const RequestLocationPermissionEvent());
          }
        } else if (status.isPermanentlyDenied) {
          // Location permission is permanently denied
          emit(
            const PermissionStatePermanentlyDenied(
              message:
                  'Location permission is permanently denied by you. Please grant the permission from app settings.',
            ),
          );
          await AppSettings.openAppSettings(type: AppSettingsType.location);
          add(const RequestLocationPermissionEvent());
        } else if (status.isRestricted) {
          emit(
            const PermissionStateRestricted(
              message: 'Location permission is restricted by OS',
            ),
          );
        }
      } else {
        // Service is not enabled
        add(const RequestLocationServiceEnable());
      }
    } catch (e) {
      emit(
        PermissionStateError(
          error: 'Location permission error: $e',
        ),
      );
    }
  }

  FutureOr<void> _requestLocationServiceEnable(
    RequestLocationServiceEnable event,
    Emitter<PermissionState> emit,
  ) async {
    // Request location service enable
    final bool serviceEnabled = await location.requestService();
    if (serviceEnabled) {
      // If service enable recall the location the permission event again
      add(const RequestLocationPermissionEvent());
    } else {
      emit(
        const PermissionServiceNotEnableByUser(
          error:
              'Location service is not enabled by you, please enable it and grant the location permission',
        ),
      );
    }
  }

  FutureOr<void> _getCurrentUserLocation(
    RequestLocationPermissionEvent event,
    Emitter<PermissionState> emit,
  ) async {
    final locationData = await location.getLocation();
    if (locationData.latitude != null && locationData.longitude != null) {
      emit(
        PermissionStateGranted(
          latitude: locationData.latitude!,
          longitude: locationData.longitude!,
        ),
      );
    } else {
      emit(const PermissionStateGranted());
    }
  }
}

part of 'permission_bloc.dart';

@freezed
class PermissionEvent with _$PermissionEvent {
  const factory PermissionEvent.started() = PermissionEventStarted;

  const factory PermissionEvent.requestPermission(
    Permission permission, {
    @Default(false) bool shouldShowRequestRationale,
  }) = RequestPermissionEvent;

  const factory PermissionEvent.requestAllPermission(
    List<Permission> permissions, {
    @Default(false) bool shouldShowRequestRationale,
  }) = RequestAllPermissionEvent;

  const factory PermissionEvent.requestLocationPermission({
    @Default(Permission.locationAlways) Permission permission,
    @Default(false) bool shouldShowRequestRationale,
  }) = RequestLocationPermissionEvent;

  const factory PermissionEvent.requestLocationServiceEnable() =
      RequestLocationServiceEnable;

  const factory PermissionEvent.requestOpenAppSetting() = RequestOpenAppSetting;
}

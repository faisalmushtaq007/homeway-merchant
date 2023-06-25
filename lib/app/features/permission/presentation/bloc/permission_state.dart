part of 'permission_bloc.dart';

@freezed
class PermissionState with _$PermissionState {
  const factory PermissionState.initial() = PermissionStateInitial;
  const factory PermissionState.loading() = PermissionStateLoading;
  const factory PermissionState.loaded() = PermissionStateLoaded;
  const factory PermissionState.error({@Default('') String error}) =
      PermissionStateError;
  const factory PermissionState.granted(
      {@Default(0.0) double latitude,
      @Default(0.0) double longitude,
      @Default('') String message}) = PermissionStateGranted;
  const factory PermissionState.denied({@Default('') String message}) =
      PermissionStateDenied;
  const factory PermissionState.permanentlyDenied(
      {@Default('') String message}) = PermissionStatePermanentlyDenied;
  const factory PermissionState.restricted({@Default('') String message}) =
      PermissionStateRestricted;
  const factory PermissionState.limited({@Default('') String message}) =
      PermissionStateLimited;
  const factory PermissionState.provisional({@Default('') String message}) =
      PermissionStateProvisional;
  const factory PermissionState.serviceEnable({@Default('') String message}) =
      PermissionServiceEnable;
  const factory PermissionState.serviceNotEnableByUser(
      {@Default('') String error}) = PermissionServiceNotEnableByUser;
}

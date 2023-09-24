part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent with AppEquatable {}

class OnConnectivityEvent extends ConnectivityEvent {
  OnConnectivityEvent(
      {required this.connectivityResult, required this.connectivityStatus});

  final ConnectivityResult connectivityResult;
  final InternetConnectivityStatus connectivityStatus;

  @override
  // TODO(prasant): implement cacheHash
  bool get cacheHash => true;

  @override
  // TODO(prasant): implement hashParameters
  List<Object?> get hashParameters => [connectivityResult, connectivityStatus];
}

class OnNotConnectivityEvent extends ConnectivityEvent {
  OnNotConnectivityEvent(
      {required this.connectivityResult, required this.connectivityStatus});

  final ConnectivityResult connectivityResult;
  final InternetConnectivityStatus connectivityStatus;

  @override
  // TODO(prasant): implement cacheHash
  bool get cacheHash => true;

  @override
  // TODO(prasant): implement hashParameters
  List<Object?> get hashParameters => [connectivityResult, connectivityStatus];
}

class OnWeakConnectivityEvent extends ConnectivityEvent {
  OnWeakConnectivityEvent(
      {required this.connectivityResult, required this.connectivityStatus});

  final ConnectivityResult connectivityResult;
  final InternetConnectivityStatus connectivityStatus;

  @override
  // TODO(prasant): implement cacheHash
  bool get cacheHash => true;

  @override
  // TODO(prasant): implement hashParameters
  List<Object?> get hashParameters => [connectivityResult, connectivityStatus];
}

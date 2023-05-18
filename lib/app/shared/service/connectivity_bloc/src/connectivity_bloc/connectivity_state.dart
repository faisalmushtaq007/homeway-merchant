part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityState with AppEquatable {}

class ConnectivityInitialState extends ConnectivityState {
  @override
  // TODO: implement cacheHash
  bool get cacheHash => true;

  @override
  // TODO: implement hashParameters
  List<Object?> get hashParameters => [];
}

class ConnectivityConnectedState extends ConnectivityState {
  ConnectivityConnectedState(
      {required this.connectivityResult, required this.connectivityStatus});

  final ConnectivityResult connectivityResult;
  final InternetConnectivityStatus connectivityStatus;

  @override
  // TODO: implement cacheHash
  bool get cacheHash => true;

  @override
  // TODO: implement hashParameters
  List<Object?> get hashParameters => [connectivityResult, connectivityStatus];
}

class ConnectivityDisconnectedState extends ConnectivityState {
  ConnectivityDisconnectedState(
      {required this.connectivityResult, required this.connectivityStatus});

  final ConnectivityResult connectivityResult;
  final InternetConnectivityStatus connectivityStatus;

  @override
  // TODO: implement cacheHash
  bool get cacheHash => true;

  @override
  // TODO: implement hashParameters
  List<Object?> get hashParameters => [connectivityResult, connectivityStatus];
}

class ConnectivityWeakConnectedState extends ConnectivityState {
  ConnectivityWeakConnectedState(
      {required this.connectivityResult, required this.connectivityStatus});

  final ConnectivityResult connectivityResult;
  final InternetConnectivityStatus connectivityStatus;

  @override
  // TODO: implement cacheHash
  bool get cacheHash => true;

  @override
  // TODO: implement hashParameters
  List<Object?> get hashParameters => [connectivityResult, connectivityStatus];
}

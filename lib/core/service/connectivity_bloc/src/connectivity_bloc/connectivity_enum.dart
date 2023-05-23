part of 'connectivity_bloc.dart';

enum InternetConnectivityStatus
    implements Comparable<InternetConnectivityStatus> {
  connected(connectivityStatus: 'Connected'),
  noConnected(connectivityStatus: 'Disconnected'),
  connectedButNotInternet(connectivityStatus: 'Connectecd but no internet'),
  weak(connectivityStatus: 'Weak connection');
  //ConnectivityStatus

  const InternetConnectivityStatus({required this.connectivityStatus});
  final String connectivityStatus;
  @override
  String toString() => 'InternetConnectivityStatus.$connectivityStatus';
  @override
  int compareTo(InternetConnectivityStatus other) =>
      name.length - other.connectivityStatus.length;
}

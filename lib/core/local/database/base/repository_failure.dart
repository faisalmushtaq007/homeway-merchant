import 'package:equatable/equatable.dart';

abstract class RepositoryBaseFailure {}

enum RepositoryFailureOrigin { local, remote, connectivity }

class RepositoryFailure extends Equatable implements RepositoryBaseFailure {
  final RepositoryFailureOrigin origin;
  final String message;
  final dynamic extra;
  final StackTrace? stacktrace;
  RepositoryFailure(
    this.origin,
    this.message, {
    this.extra,
    this.stacktrace,
  });

  factory RepositoryFailure.server(String message) =>
      RepositoryFailure(RepositoryFailureOrigin.remote, message);

  factory RepositoryFailure.localdb(
    String message, {
    dynamic extra,
    StackTrace? stacktrace,
  }) =>
      RepositoryFailure(RepositoryFailureOrigin.local, message,
          extra: extra, stacktrace: stacktrace);

  factory RepositoryFailure.cache(String message) =>
      RepositoryFailure(RepositoryFailureOrigin.local, message);

  factory RepositoryFailure.connectivity() => RepositoryFailure(
      RepositoryFailureOrigin.connectivity, 'No internet connection');

  @override
  List<Object?> get props => [origin, message];

  @override
  bool get stringify => true;
}

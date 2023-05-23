import 'data/i_app_equatable.dart';
import 'equality.dart';
import 'i_hash_engine.dart';
import 'jenkins_hash_engine.dart';
import 'package:meta/meta.dart';

mixin AppEquatable implements IAppEquatable {
  int? _cachedHash;

  @override
  @protected
  final bool additionalEqualityCheck = true;

  @override
  @protected
  IHashEngine get hashEngine => const JenkinsHashEngine();

  @override
  int get hashCode {
    if (cacheHash) {
      return _cachedHash ??= hashEngine.calculateHash(hashParameters);
    }

    return hashEngine.calculateHash(hashParameters);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IAppEquatable &&
            runtimeType == other.runtimeType &&
            fastEquals(this, other));
  }
}

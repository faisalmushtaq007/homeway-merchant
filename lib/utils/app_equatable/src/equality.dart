import 'package:collection/collection.dart';

import 'data/i_app_equatable.dart';

const _deepEquality = DeepCollectionEquality();

bool fastEquals(IAppEquatable main, IAppEquatable other) {
  if (main.cacheHash || other.cacheHash) {
    return main.hashCode == other.hashCode &&
        (!(main.additionalEqualityCheck && other.additionalEqualityCheck) ||
            _deepEquality.equals(main.hashParameters, other.hashParameters));
  }

  final params = main.hashParameters;
  final otherParams = other.hashParameters;

  final length = params.length;
  if (length != otherParams.length) return false;

  for (var i = 0; i < length; i++) {
    final a = params[i];
    final b = otherParams[i];

    if (a is IAppEquatable && b is IAppEquatable) {
      return fastEquals(a, b);
    } else if (_deepEquality.isValidKey(a)) {
      if (!_deepEquality.equals(a, b)) return false;
    } else if (a?.runtimeType != b?.runtimeType) {
      return false;
    } else if (a != b) {
      return false;
    }
  }

  return true;
}

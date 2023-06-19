class ConditionalSwitchData {
  ConditionalSwitchData._();
  static R single<T, R>({
    required T Function() valueBuilder,
    required Map<T, R Function()> caseBuilders,
    required R Function() fallbackBuilder,
  }) {
    final T value = valueBuilder();
    if (caseBuilders[value] != null) {
      return caseBuilders[value]!();
    } else {
      return fallbackBuilder();
    }
  }

  static List<R> list<T, R>({
    required T Function() valueBuilder,
    required Map<T, List<R> Function()> caseBuilders,
    required List<R> Function() fallbackBuilder,
  }) {
    final T value = valueBuilder();
    if (caseBuilders[value] != null) {
      return caseBuilders[value]!();
    } else {
      return fallbackBuilder();
    }
  }
}

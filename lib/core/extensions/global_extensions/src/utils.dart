void checkNullError(Object o) {
  // ignore: unnecessary_null_comparison
  if (o == null) {
    throw NullIteratorError();
  }
}

class NullIteratorError extends TypeError {
  @override
  String toString() {
    return '(NullIteratorError) Cannot call extension method on null.';
  }
}

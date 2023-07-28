enum StateStatus {
  none,
  showLoading,
  hideLoading,
  processing,
  progressing,
  loaded,
  success,
  failed,
  exception,
  empty,
  ;

  @override
  String toString() {
    return name;
  }
}

enum ActionOnSearchAndFilter {
  none,
  loading,
  searching,
  filtering,
  finding,
  success,
  failed,
  exception,
  empty,
  ;

  @override
  String toString() {
    return name;
  }
}

enum Options { view, edit, removeFromStore, delete }

enum BindToStoreStage {
  none,
  select,
  save,
  remove,
  attached,
  success,
  failed,
  exception,
  attaching,
  processing,
  ;

  @override
  String toString() {
    return name;
  }
}

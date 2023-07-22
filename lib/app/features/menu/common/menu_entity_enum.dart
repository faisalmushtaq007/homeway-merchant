part of 'package:homemakers_merchant/app/features/menu/index.dart';

enum MenuEntityStatus {
  push,
  pull,
  failed,
  exception,
  pushed,
  pulled,
  none,
  ;

  @override
  String toString() {
    return name;
  }
}

enum MenuFormStage {
  form1,
  form2,
  form3,
  form4,
  form5,
  none,
  ;

  @override
  String toString() {
    return name;
  }
}

enum MenuSelectionUseCase {
  createNewWithStore,
  createNewWithoutStore,
  associateExistingMultipleStore,
  delete,
  view,
  removeFromStore,
  deleteAll,
  edit,
  none,
}

enum MenuStateStatus {
  none,
  loading,
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

enum ActionOnFindMenu {
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

enum MenuOptions { view, edit, removeFromStore, delete }

enum BindMenuToStoreStage {
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

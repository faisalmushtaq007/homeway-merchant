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
  getByID,
  getAll,
  edit,
  none,
  loading,
  processing,
  progressing,
  loaded,
  success,
  failed,
  exception,
  empty,
  bindingWithStore,
  bindingWithUser,
  getAllMenuPagination,
  saveAllMenu,
  ;

  @override
  String toString() {
    return name;
  }
}

enum AddonsSelectionUseCase {
  createNewWithStore,
  createNewWithoutStore,
  associateExistingMultipleStore,
  delete,
  view,
  removeFromStore,
  deleteAll,
  save,
  getByID,
  getAll,
  edit,
  none,
  loading,
  processing,
  progressing,
  loaded,
  success,
  failed,
  exception,
  emptyForAddons,
  bindingWithMenu,
  bindingWithUser,
  getAllAddonsPagination,
  saveAllAddons,
  ;

  @override
  String toString() {
    return name;
  }
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
  createNewWithStore,
  createNewWithoutStore,
  associateExistingMultipleStore,
  delete,
  view,
  removeFromStore,
  deleteAll,
  getByID,
  getAll,
  edit,
  getAllMenuPagination,
  saveAllMenu,
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

enum BindMenuToUserStage {
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

enum BindAddonsToMenuStage {
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

enum BindAddonsToUserStage {
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

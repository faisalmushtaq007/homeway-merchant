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

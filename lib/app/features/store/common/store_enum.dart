enum StoreStateStage {
  createNewWithStore,
  createNewWithoutStore,
  associateExistingMultipleStore,
  delete,
  view,
  removeMenuFromStore,
  removeDriverFromStore,
  deleteAll,
  edit,
  none,
  bindDriverWithStores,
  bindMenuWithStores,
  forDriver,
  forMenu,
  getStore,
  getAllStore,
  loading,
  processing,
  progressing,
  loaded,
  success,
  failed,
  exception,
  empty,
  bindingWithUser,
  getAllStoresPagination,
  ;

  @override
  String toString() {
    return name;
  }
}

enum DriverStateStage {
  saveDriver,
  editDriver,
  deleteDriver,
  deleteAllDriver,
  getDriver,
  getAllDriver,
  removeFromStore,
  associateExistingMultipleStore,
  loading,
  processing,
  progressing,
  loaded,
  success,
  failed,
  exception,
  empty,
  none,
  bindingWithStore,
  bindingWithUser,
  getAllDriversPagination,
  ;

  @override
  String toString() {
    return name;
  }
}

enum BindingStage {
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
  bindingStoreWithUser,
  bindingWithUser,
  bindingAddonsWithUser,
  bindingAddonsWithMenu,
  bindingMenuWithUser,
  bindingMenuWithStore,
  bindingDriverWithUser,
  bindingDriverWithStore,
  unbindingStoreWithUser,
  unbindingWithUser,
  unbindingAddonsWithUser,
  unbindingAddonsWithMenu,
  unbindingMenuWithUser,
  unbindingMenuWithStore,
  unbindingDriverWithUser,
  unbindingDriverWithStore,
  ;

  @override
  String toString() {
    return name;
  }
}

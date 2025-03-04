enum BlocStatus<T extends Object> {
  none,
  save,
  delete,
  get,
  navigate,
  exception,
  failed,
  loading,
  processing,
  empty,
  deleteAll,
  getAll,
  ;

  @override
  String toString() {
    return name;
  }
}

enum AppOptions<T extends Object> {
  view<String>(value: 'View'),
  edit<String>(value: 'Edit'),
  select<String>(value: 'Select'),
  remove<String>(value: 'Remove'),
  delete<String>(value: 'Delete'),
  setAsDefault<String>(value: 'Set as Default'),
  ;

  const AppOptions({required this.value});
  final T value;
}

enum SelectItemUseCase {
  bindingWithOther,
  onlySelect,
  selectAndReturn,
  selectAndNext,
  none,
}

enum SelectionUseCase {
  bindingWithOther,
  onlySelect,
  selectAndReturn,
  selectAndNext,
  saveAndNext,
  saveAndReturn,
  deleteAndNext,
  deleteAndReturn,
  updateAndNext,
  updateAndReturn,
  none,
}

enum OrderStateStatus {
  none,
  save,
  delete,
  get,
  navigate,
  exception,
  failed,
  loading,
  processing,
  empty,
  deleteAll,
  getAll,
  getAllNew,
  getAllRecent,
  getAllCancel,
  getAllSchedule,
  getAllDeliver,
  getAllProcessing,
  ;

  @override
  String toString() {
    return name;
  }
}

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

enum AssetsUploadStatus {
  none,
  pending,
  uploaded,
  removed,
  added,
  ;

  @override
  String toString() {
    return name;
  }
}

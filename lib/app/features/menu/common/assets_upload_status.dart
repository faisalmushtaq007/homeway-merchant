part of 'package:homemakers_merchant/app/features/menu/index.dart';

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

import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/dart_extensions.dart';

ImageType findImageType(String? assetsPath) {
  if (assetsPath.isEmptyOrNull) {
    return ImageType.text;
  } else {
    switch (assetsPath) {
      case (final String path) when path.startsWith('http') || path.startsWith('https') || path.contains('http') || path.contains('https'):
        {
          return ImageType.network;
        }
      case (final String path) when path.startsWith('/') || path.startsWith('//'):
        {
          return ImageType.file;
        }
      case (final String path) when path.contains('.svg') || assetsPath.contains('assets/svg/') || assetsPath.startsWith('assets/svg/'):
        {
          return ImageType.svg;
        }
      case (final String path) when path.startsWith('assets/') || path.contains('assets/image'):
        {
          return ImageType.asset;
        }
      case (final String path) when path.contains('.jpg') || path.contains('.png'):
        {
          return ImageType.file;
        }
      case _:
        {
          return ImageType.text;
        }
    }
  }
}

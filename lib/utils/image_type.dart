import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/dart_extensions.dart';

ImageType findImageType(String? assetsPath) {
  if (assetsPath.isEmptyOrNull) {
    return ImageType.text;
  } else {
    switch (assetsPath) {
      case (final String path) when path.startsWith('http') || path.startsWith('https'):
        {
          return ImageType.network;
        }
      case (final String path) when path.startsWith('/') || path.startsWith('//'):
        {
          return ImageType.file;
        }
      case (final String path) when path.contains('.svg'):
        {
          return ImageType.svg;
        }
      case _:
        {
          return ImageType.text;
        }
    }
  }
}

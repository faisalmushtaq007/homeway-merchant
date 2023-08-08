import 'package:flutter/cupertino.dart';
import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';
import 'package:homemakers_merchant/utils/app_equatable/src/app_equatable.dart';

class ImageEntity with AppEquatable {
  ImageEntity({
    this.imageType = ImageType.network,
    this.imagePath = '',
    this.icon,
    this.hasIcon = false,
    this.metaData = const {},
  });

  factory ImageEntity.fromMap(Map<String, dynamic> map) {
    return ImageEntity(
      imageType: ImageType.values.byName(map['imageType']),
      imagePath: map['imagePath'] as String,
      icon: map['icon'] as Icon,
      hasIcon: map['hasIcon'] as bool,
      metaData: map['metaData'] as Map<String, dynamic>,
    );
  }
  final ImageType imageType;
  final String imagePath;
  final Icon? icon;
  final bool hasIcon;
  final Map<String, dynamic> metaData;

  @override
  String toString() {
    return 'ImageEntity{ imageType: $imageType, imagePath: $imagePath, icon: $icon, hasIcon: $hasIcon, metaData: $metaData,}';
  }

  ImageEntity copyWith({
    ImageType? imageType,
    String? imagePath,
    Icon? icon,
    bool? hasIcon,
    Map<String, dynamic>? metaData,
  }) {
    return ImageEntity(
      imageType: imageType ?? this.imageType,
      imagePath: imagePath ?? this.imagePath,
      icon: icon ?? this.icon,
      hasIcon: hasIcon ?? this.hasIcon,
      metaData: metaData ?? this.metaData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageType': this.imageType,
      'imagePath': this.imagePath,
      'icon': this.icon,
      'hasIcon': this.hasIcon,
      'metaData': this.metaData,
    };
  }

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        imageType,
        imagePath,
        icon,
        hasIcon,
        metaData,
      ];
}

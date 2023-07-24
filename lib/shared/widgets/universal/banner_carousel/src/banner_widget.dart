import 'package:homemakers_merchant/shared/widgets/universal/banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';

@immutable
class BannerWidget extends StatelessWidget {
  final BannerModel _bannerModel;

  /// The [borderRadius] of the container
  /// Default value 5
  final double borderRadius;

  /// The [_onTap] The Method when click on the Banner
  final VoidCallback _onTap;

  final double spaceBetween;

  BannerWidget({
    Key? key,
    required BannerModel bannerModel,
    this.borderRadius = 5,
    this.spaceBetween = 0,
    required VoidCallback onTap,
  })  : _bannerModel = bannerModel,
        _onTap = onTap,
        super(key: key);

  ImageProvider get _getImage {
    if (_bannerModel.imagePath.contains("https://") || _bannerModel.imagePath.contains("http://")) {
      return NetworkImage(_bannerModel.imagePath);
    }
    return AssetImage(_bannerModel.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    /*return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: spaceBetween),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: _getImage,
              fit: _bannerModel.boxFit,
            ),
            borderRadius: BorderRadius.circular(borderRadius)),
        width: double.maxFinite,
        // child: SizedBox(),
      ),
    );*/
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: spaceBetween),
        width: double.maxFinite,
        child: ImageHelper(
          image: _bannerModel.imagePath,
          // image scale
          scale: 1.0,
          // Quality levels for image sampling in [ImageFilter] and [Shader] objects that sample
          filterQuality: FilterQuality.high,
          // border radius only work with [ImageShape.rounded]
          borderRadius: BorderRadiusDirectional.circular(10),
          // alignment of image
          //alignment: Alignment.center,
          // indicates where image will be loaded from, types are [network, asset,file]
          imageType: (_bannerModel.imagePath.isNotEmpty && (_bannerModel.imagePath.contains("https://") || _bannerModel.imagePath.contains("http://")))
              ? ImageType.network
              : ImageType.file,
          // indicates what shape you would like to be with image [rectangle, oval,circle or none]
          imageShape: ImageShape.rectangle,
          // image default box fit
          boxFit: _bannerModel.boxFit,
          width: double.maxFinite,
          height: double.maxFinite,
          // imagePath: 'assets/images/image.png',
          // default loader color, default value is null
          //defaultLoaderColor: Colors.red,
          // default error builder color, default value is null
          defaultErrorBuilderColor: Colors.blueGrey,
          // the color you want to change image with
          //color: Colors.blue,
          // blend mode with image only
          //blendMode: BlendMode.srcIn,
          // error builder widget, default as icon if null
          errorBuilder: const Icon(
            Icons.image_not_supported,
            size: 10000,
          ),
          // loader builder widget, default as icon if null
          loaderBuilder: const CircularProgressIndicator(),
          matchTextDirection: true,
          /*placeholderText: widget.storeEntity.storeName,
          placeholderTextStyle: context.labelLarge!.copyWith(
            color: Colors.white,
            fontSize: 16,
          ),
          placeholderBackgroundColor: context.colorScheme.primary.withOpacity(0.5),*/
        ),
      ),
    );
  }
}

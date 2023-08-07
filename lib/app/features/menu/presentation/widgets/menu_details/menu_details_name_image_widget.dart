part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuDetailsNameImageWidget extends StatelessWidget {
  const MenuDetailsNameImageWidget({super.key, required this.menuEntity});
  final MenuEntity menuEntity;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Card(
        child: ListTile(
          minLeadingWidth: 80,
          leading: ImageHelper(
            image: menuEntity.menuImages[0].assetPath,
            //'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg',
            // image scale
            scale: 1.0,
            // Quality levels for image sampling in [ImageFilter] and [Shader] objects that sample
            filterQuality: FilterQuality.high,
            // border radius only work with [ImageShape.rounded]
            borderRadius: BorderRadiusDirectional.circular(0),
            // alignment of image
            //alignment: Alignment.center,

            // indicates what shape you would like to be with image [rectangle, oval,circle or none]
            imageShape: ImageShape.rectangle,
            // image default box fit
            boxFit: BoxFit.fill,
            width: context.width / 2.15,
            height: context.width / 2.15,
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
            semanticLabel: 'menu image',
            matchTextDirection: true,
            placeholderText: menuEntity.menuName,
            placeholderTextStyle: context.labelLarge!.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
            // indicates where image will be loaded from, types are [network, asset,file]
            placeholderBackgroundColor: context.colorScheme.primary.withOpacity(0.5),
            imageType: findImageType(
              menuEntity.menuImages[0].assetPath.isEmptyOrNull ? 'assets/svg/sorry-image-not-available.svg' : menuEntity.menuImages[0].assetPath,
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            children: [
              // Menu name
              Text(
                menuEntity.menuName,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                style: context.titleMedium,
              ),
              // Menu ID
              Text(
                '',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                style: context.labelMedium,
              ),
              // Manu Rating
              Chip(
                labelPadding: const EdgeInsetsDirectional.all(1),
                avatar: const SingleStarRating(
                  rating: 4.2,
                  starColor: Color.fromRGBO(42, 45, 50, 1),
                  starSize: 16,
                ),
                label: Text(
                  '4.2',
                  style: context.labelSmall!.copyWith(
                    color: const Color.fromRGBO(42, 45, 50, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ),
                backgroundColor: const Color.fromRGBO(69, 201, 125, 1),
                elevation: 0.0,
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsetsDirectional.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  side: const BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
              ),
              // Menu Category
              Chip(
                labelPadding: const EdgeInsetsDirectional.all(2),
                label: Text(
                  menuEntity.menuCategories[0].title,
                  style: context.labelSmall!.copyWith(
                    color: const Color.fromRGBO(42, 45, 50, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ),
                backgroundColor: context.colorScheme.primary,
                elevation: 0.0,
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsetsDirectional.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  side: const BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

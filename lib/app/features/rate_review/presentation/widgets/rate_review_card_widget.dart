part of 'package:homemakers_merchant/app/features/rate_review/index.dart';

class RateAndReviewCardWidget extends StatelessWidget {
  const RateAndReviewCardWidget({
    required this.rateAndReviewEntity,
    super.key,
  });

  final RateAndReviewEntity rateAndReviewEntity;

  @override
  Widget build(BuildContext context) {
    final String imagePath = rateAndReviewEntity.body.iconUrl.isNotEmpty
        ? rateAndReviewEntity.body.iconUrl
        : rateAndReviewEntity.body.imageUrl.isNotEmpty
            ? rateAndReviewEntity.body.imageUrl
            : 'assets/svg/mail.svg';
    final minLeadingWidth = 26.0;
    final radius = 28.0;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
        leading: SizedBox(
          width: minLeadingWidth,
          child: ImageHelper(
            image: imagePath,
            color: context.colorScheme.primary,
            // image scale
            scale: 1.0,
            // Quality levels for image sampling in [ImageFilter] and [Shader] objects that sample
            filterQuality: FilterQuality.high,
            // border radius only work with [ImageShape.rounded]
            borderRadius: BorderRadiusDirectional.circular(6),
            // alignment of image
            //alignment: Alignment.center,
            // indicates where image will be loaded from, types are [network, asset,file]
            imageType: findImageType(imagePath),
            // indicates what shape you would like to be with image [rectangle, oval,circle or none]
            imageShape: ImageShape.rectangle,
            // image default box fit
            boxFit: BoxFit.contain,
            width: radius,
            height: radius,
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
            placeholderText: rateAndReviewEntity.title,
            placeholderTextStyle: context.labelLarge!.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
            placeholderBackgroundColor: context.colorScheme.primary.withOpacity(0.0),
          ),
        ),
        minLeadingWidth: minLeadingWidth,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              children: [
                Text(
                  rateAndReviewEntity.title,
                  style: context.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: rateAndReviewEntity.flag == 0 ? null : Colors.grey[500],
                  ),
                ).translate(),
              ],
            ),
            Wrap(
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              children: [
                Text(
                  rateAndReviewEntity.body.message,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyMedium!.copyWith(
                    color: rateAndReviewEntity.flag == 0 ? null : Colors.grey[400],
                  ),
                ).translate(),
              ],
            ),
          ],
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
        trailing: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth / 5.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Wrap(
                    children: [
                      Text(
                        DateTimeFormat.relative(
                          DateTime.now().subtract(
                            DateTime.now().difference(
                              DateTime.fromMillisecondsSinceEpoch(rateAndReviewEntity.timestamp * 1000),
                            ),
                          ),
                          appendIfAfter: 'ago',
                          prependIfBefore: 'In',
                          abbr: true,
                        ),
                        style: context.bodySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  const AnimatedGap(6, duration: Duration(milliseconds: 200)),
                  rateAndReviewEntity.flag == 0
                      ? Container(
                          width: 40.0,
                          height: 20.0,
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(30.0)),
                          alignment: Alignment.center,
                          child: Text(
                            "NEW",
                            style: context.labelSmall!.copyWith(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                      : const Offstage(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

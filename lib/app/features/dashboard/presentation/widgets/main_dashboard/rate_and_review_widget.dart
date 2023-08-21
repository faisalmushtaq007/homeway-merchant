part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class DashboardRateAndReviewWidget extends StatelessWidget {
  const DashboardRateAndReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color.fromRGBO(215, 243, 227, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      leading: SizedBox.square(
        dimension: 40,
        child: ImageHelper(
          image: 'assets/svg/rating_star.svg',
          filterQuality: FilterQuality.high,
          borderRadius: BorderRadiusDirectional.circular(30),
          imageType: ImageType.svg,
          imageShape: ImageShape.rectangle,
          boxFit: BoxFit.fill,
          width: context.width / 10,
          height: context.width / 10,
          defaultErrorBuilderColor: Colors.blueGrey,
          errorBuilder: const Icon(
            Icons.image_not_supported,
            size: 10000,
          ),
          loaderBuilder: const CircularProgressIndicator(),
          matchTextDirection: true,
        ),
      ),
      title: Text(
        'Rate and Reviews',
        style: context.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            children: [
              Text(
                '185',
                style: context.labelMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(255, 90, 39, 1),
                ),
              ).translate(),
            ],
          ),
          const AnimatedGap(4, duration: Duration(milliseconds: 100)),
          Wrap(
            children: [
              Text(
                'rating by customers',
                style: context.labelMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ).translate(),
            ],
          ),
        ],
      ),
    );
  }
}

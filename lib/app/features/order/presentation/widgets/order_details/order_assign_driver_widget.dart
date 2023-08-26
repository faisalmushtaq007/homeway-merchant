part of 'package:homemakers_merchant/app/features/order/index.dart';

class AssignDriverWidget extends StatelessWidget {
  const AssignDriverWidget({required this.orderEntity, super.key});

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(orderEntity.driver.driverID),
      margin: EdgeInsetsDirectional.only(bottom: 8),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 8),
            horizontalTitleGap: 8,
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 24,
              child: ImageHelper(
                image: 'assets/svg/driver_found.svg',
                filterQuality: FilterQuality.high,
                borderRadius: BorderRadiusDirectional.circular(10),
                imageType: findImageType('assets/svg/driver_found.svg'),
                imageShape: ImageShape.rectangle,
                boxFit: BoxFit.cover,
                defaultErrorBuilderColor: Colors.blueGrey,
                errorBuilder: const Icon(
                  Icons.image_not_supported,
                  size: 10000,
                ),
                loaderBuilder: const CircularProgressIndicator(),
                matchTextDirection: true,
                placeholderText: orderEntity.driver.driverName,
                placeholderTextStyle: context.labelLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            title: Text(
              orderEntity.driver.driverName,
              style: context.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 3,
            ),
            trailing: SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.chat,
                        color: context.colorScheme.primary,
                      ),
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        shape: CircleBorder(),
                      )),
                  IconButton(
                      icon: Icon(
                        Icons.phone_in_talk,
                        color: context.colorScheme.primary,
                      ),
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        shape: CircleBorder(),
                      )),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Text(
                'On the way',
                style: context.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
              ),
              const AnimatedGap(
                6,
                duration: Duration(milliseconds: 100),
              ),
              Text(
                '4 KM',
                style: context.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
              ),
              const AnimatedGap(
                6,
                duration: Duration(milliseconds: 100),
              ),
              Text(
                '15 Min',
                style: context.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

part of 'package:homemakers_merchant/app/features/order/index.dart';

class DriverAssignCardWidget extends StatefulWidget {
  const DriverAssignCardWidget({required this.orderEntity, required this.index, super.key});
  final int index;
  final OrderEntity orderEntity;
  @override
  _DriverAssignCardWidgetController createState() => _DriverAssignCardWidgetController();
}

class _DriverAssignCardWidgetController extends State<DriverAssignCardWidget> {
  @override
  Widget build(BuildContext context) => _DriverAssignCardWidgetView(this);
}

class _DriverAssignCardWidgetView extends WidgetView<DriverAssignCardWidget, _DriverAssignCardWidgetController> {
  const _DriverAssignCardWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          thickness: 0.75,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          children: [
            Expanded(
              child: ListTile(
                /*shape: RoundedRectangleBorder(
                                side: BorderSide(width: 0.5),
                                borderRadius: BorderRadius.circular(1),
                              ),*/
                visualDensity: VisualDensity(horizontal: -3, vertical: -3),
                dense: true,
                minVerticalPadding: 0,
                isThreeLine: false,
                minLeadingWidth: 30,
                horizontalTitleGap: 8,
                contentPadding: EdgeInsetsDirectional.zero,
                leading: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                  ),
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
                    height: context.width / 10,
                    width: context.width / 10,
                    loaderBuilder: const CircularProgressIndicator(),
                    matchTextDirection: true,
                    placeholderText: widget.orderEntity.store.menu[0].menuName,
                    placeholderTextStyle: context.labelLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                title: Directionality(
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  child: WrapText(
                    widget.orderEntity.driver.driverName,
                    breakWordCharacter: '-',
                    smartSizeMode: false,
                    asyncMode: true,
                    minFontSize: 12,
                    maxFontSize: 14,
                    textStyle: context.labelSmall!.copyWith(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                subtitle: Directionality(
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  child: WrapText(
                    widget.orderEntity.driver.contactNumber,
                    breakWordCharacter: '-',
                    smartSizeMode: false,
                    asyncMode: true,
                    minFontSize: 12,
                    maxFontSize: 14,
                    textStyle: context.labelSmall!.copyWith(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
            ),
          ],
        ),
        const AnimatedGap(8, duration: Duration(milliseconds: 100)),
      ],
    );
  }
}

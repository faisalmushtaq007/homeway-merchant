part of 'package:homemakers_merchant/app/features/order/index.dart';

class ManageOrderHeadlineWidget extends StatefulWidget {
  const ManageOrderHeadlineWidget({super.key});

  @override
  State<ManageOrderHeadlineWidget> createState() =>
      _ManageOrderHeadlineWidgetState();
}

class _ManageOrderHeadlineWidgetState extends State<ManageOrderHeadlineWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      children: [
        Icon(
          Icons.room_service,
          color: context.colorScheme.primary,
          size: 30,
        ),
        const AnimatedGap(
          8,
          duration: Duration(milliseconds: 100),
        ),
        Text(
          'Manage Orders',
          style: context.headlineSmall!.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ).translate(),
        Spacer(),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Color.fromRGBO(238, 238, 238, 1),
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          child: IconButton(
            onPressed: () {},
            //color: Color.fromRGBO(238, 238, 238, 1),
            constraints: BoxConstraints(
              minWidth: kMinInteractiveDimension - 4,
              minHeight: kMinInteractiveDimension - 4,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Color.fromRGBO(238, 238, 238, 1),
            ),
            icon: Icon(
              Icons.more_horiz,
              color: Color.fromRGBO(165, 166, 168, 1),
            ),
          ),
        ),
      ],
    );
  }
}

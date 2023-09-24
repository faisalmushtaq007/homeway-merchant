import 'package:flutter/material.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';

class StoreOrderInfo {
  const StoreOrderInfo({
    required this.title,
    required this.subTitle,
    required this.titleTextColor,
    required this.subTitleTextColor,
    this.onPressed,
    this.hasOpenUrl = false,
  });

  final String title;
  final String subTitle;
  final Color titleTextColor;
  final VoidCallback? onPressed;
  final Color subTitleTextColor;
  final bool hasOpenUrl;
}

class StoreOrderCardWidget extends StatelessWidget {
  const StoreOrderCardWidget({
    super.key,
    required this.storeOrderInfo,
  });

  final StoreOrderInfo storeOrderInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          storeOrderInfo.title,
          style: context.titleMedium!.copyWith(
            color: storeOrderInfo.subTitleTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const AnimatedGap(3, duration: Duration(milliseconds: 100)),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              storeOrderInfo.subTitle,
              style: context.titleMedium!.copyWith(
                  color: storeOrderInfo.subTitleTextColor,
                  fontWeight: FontWeight.w600),
            ),
            Visibility(
              visible: storeOrderInfo.hasOpenUrl,
              child: const AnimatedGap(
                6,
                duration: Duration(milliseconds: 100),
              ),
              replacement: const Offstage(),
            ),
            Visibility(
              visible: storeOrderInfo.hasOpenUrl,
              child: InkWell(
                onTap: storeOrderInfo.onPressed,
                child: Icon(
                  Icons.open_in_new,
                  size: 14,
                  color: Color.fromRGBO(127, 129, 132, 1),
                ),
              ),
              replacement: const Offstage(),
            ),
          ],
        ),
      ],
    );
  }
}

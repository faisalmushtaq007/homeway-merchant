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
  });
  final String title;
  final String subTitle;
  final Color titleTextColor;
  final VoidCallback? onPressed;
  final Color subTitleTextColor;
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
        Text(
          storeOrderInfo.subTitle,
          style: context.titleMedium!.copyWith(color: storeOrderInfo.subTitleTextColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

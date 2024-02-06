import 'package:flutter/material.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/src/widgets/animated_gap.dart';

class BigUserCard extends StatelessWidget {
  const BigUserCard({
    required this.userName,
    this.userProfilePic,
    super.key,
    this.backgroundColor,
    this.settingColor,
    this.cardRadius = 30,
    this.backgroundMotifColor = Colors.white,
    this.cardActionWidget,
    this.userMoreInfo,
    this.margin,
    this.userProfileImageWidget,
    this.customProfileImageWidget,
    this.subTitle = '',
  });
  final Color? backgroundColor;
  final Color? settingColor;
  final double? cardRadius;
  final Color? backgroundMotifColor;
  final Widget? cardActionWidget;
  final String? userName;
  final String? subTitle;
  final Widget? userMoreInfo;
  final ImageProvider? userProfilePic;
  final EdgeInsetsGeometry? margin;
  final Widget? userProfileImageWidget;
  final Widget? customProfileImageWidget;

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Container(
        height: mediaQueryHeight / 4,
        margin: margin ?? const EdgeInsetsDirectional.only(bottom: 20),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).cardColor,
          borderRadius:
              BorderRadius.circular(double.parse(cardRadius!.toString())),
        ),
        child: Stack(
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: backgroundMotifColor!.withOpacity(.1),
              ),
            ),
            Align(
              child: CircleAvatar(
                radius: 400,
                backgroundColor: backgroundMotifColor!.withOpacity(.05),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: (cardActionWidget != null)
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    children: [
                      // User profile
                      Expanded(
                        child: AnimatedCrossFade(
                          duration: const Duration(milliseconds: 500),
                          crossFadeState: (customProfileImageWidget.isNotNull)
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild:
                              customProfileImageWidget ?? const Offstage(),
                          secondChild: CircleAvatar(
                            radius: context.width / 9,
                            backgroundImage: userProfilePic,
                            backgroundColor: Colors.transparent,
                            child: userProfileImageWidget,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          children: [
                            Wrap(
                              children: [
                                Text(
                                  userName!,
                                  style: context.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    //fontSize: context.width / 15,
                                    height: 0.9,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                ).translate(),
                              ],
                            ),
                            AnimatedCrossFade(
                              firstChild: const Offstage(),
                              crossFadeState: subTitle.isNotNull
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 400),
                              secondChild: Column(
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                children: [
                                  const AnimatedGap(
                                    4,
                                    duration: Duration(milliseconds: 400),
                                  ),
                                  Wrap(
                                    children: [
                                      Text(
                                        subTitle ?? '',
                                        style: context.titleMedium!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          //fontSize: context.width / 15,
                                          //height: 0.9,
                                          color: Colors.white,
                                        ),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textDirection:
                                            serviceLocator<LanguageController>()
                                                .targetTextDirection,
                                      ).translate(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (userMoreInfo != null) ...[
                              userMoreInfo!,
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: settingColor ?? Theme.of(context).cardColor,
                    ),
                    child: (cardActionWidget != null)
                        ? cardActionWidget
                        : Container(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';

class SimpleUserCard extends StatelessWidget {
  const SimpleUserCard({
    super.key,
    required this.userProfilePic,
    required this.userName,
    this.imageRadius = 10,
    this.userMoreInfo,
    this.onTap,
    this.textStyle,
    this.icon,
  });

  final ImageProvider userProfilePic;
  final String userName;
  final double? imageRadius;
  final Widget? userMoreInfo;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: SizedBox(
        width: mediaQueryWidth,
        height: mediaQueryHeight / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          children: [
            GestureDetector(
              onTap: (onTap == null) ? () {} : onTap,
              child: Stack(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(imageRadius!),
                    child: Image(
                      image: userProfilePic,
                      fit: BoxFit.cover,
                      height: mediaQueryHeight / 5,
                      width: mediaQueryWidth / 2.6,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: (icon != null)
                        ? icon!
                        : Icon(
                            Icons.camera,
                            color: Colors.transparent,
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 3),
              child: Wrap(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Text(
                    userName,
                    style: (textStyle == null)
                        ? context.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            //fontSize: context.width / 15,
                            height: 0.9,
                            color: Colors.white,
                          )
                        : textStyle,
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    softWrap: true,
                  ).translate(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

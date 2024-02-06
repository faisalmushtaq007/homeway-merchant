import 'package:flutter/material.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';

class SmallUserCard extends StatelessWidget {
  const SmallUserCard({
    super.key,
    required this.cardColor,
    this.cardRadius = 30,
    required this.userName,
    this.backgroundMotifColor = Colors.white,
    this.userMoreInfo,
    required this.userProfilePic,
    required this.onTap,
    this.margin,
  });
  final Color? cardColor;
  final double? cardRadius;
  final Color? backgroundMotifColor;
  final VoidCallback? onTap;
  final String? userName;
  final Widget? userMoreInfo;
  final ImageProvider userProfilePic;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: mediaQueryHeight / 6,
          margin: margin ?? const EdgeInsetsDirectional.only(bottom: 20),
          decoration: BoxDecoration(
            color: cardColor,
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
                margin: const EdgeInsetsDirectional.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            radius: mediaQueryHeight / 18,
                            backgroundImage: userProfilePic,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            children: [
                              Text(
                                userName!,
                                style: context.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  //fontSize: context.width / 15,
                                  height: 0.9,
                                  color: Colors.white,
                                ),
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                                softWrap: true,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ).translate(),
                              if (userMoreInfo != null) ...[
                                userMoreInfo!,
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

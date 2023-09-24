import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:homemakers_merchant/utils/image_type.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;
  final bool hasIconImage;
  final bool hasEditButton;
  final bool hasCustomIcon;
  final Icon? customIcon;
  final double? end;
  final double? top;
  final double circularRadius;
  final double borderRadius;
  final double? bottom;

  // Constructor
  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
    this.hasIconImage = false,
    this.hasEditButton = true,
    this.customIcon,
    this.hasCustomIcon = false,
    this.top,
    this.end,
    this.circularRadius = 36,
    this.borderRadius = 20,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = context.primaryColor;

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          buildImage(
              color, hasIconImage, context, circularRadius, borderRadius),
          if (hasEditButton)
            PositionedDirectional(
              child: buildEditIcon(color, context),
              end: end ?? -4,
              //top: top??10,
              bottom: bottom,
            ),
        ],
      ),
    );
  }

  // Builds Profile Image
  Widget buildImage(Color color, bool hasIconImage, BuildContext context,
      [double circularRadius = 36, double borderRadius = 20]) {
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : AssetImage(imagePath);
    return AbsorbPointer(
      absorbing: false,
      child: GestureDetector(
        onTap: () async {
          return onPressed();
        },
        child: CircleAvatar(
          radius: circularRadius,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
            //backgroundImage: hasIconImage ? null : image as ImageProvider,
            child: (!hasIconImage)
                ? ImageHelper(
                    image: imagePath,
                    filterQuality: FilterQuality.high,
                    borderRadius:
                        BorderRadiusDirectional.circular(borderRadius),
                    imageType: findImageType(imagePath),
                    imageShape: ImageShape.rectangle,
                    boxFit: BoxFit.cover,
                    defaultErrorBuilderColor: Colors.blueGrey,
                    errorBuilder: const Icon(
                      Icons.image_not_supported,
                      size: 10000,
                    ),
                    height: context.width / 5,
                    width: context.width / 5,
                    loaderBuilder: const CircularProgressIndicator(),
                    matchTextDirection: true,
                  )
                : hasCustomIcon
                    ? customIcon
                    : Icon(
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        Icons.restaurant_menu,
                        size: 24.0,
                      ),
            radius: 32,
          ),
        ),
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color, BuildContext context) => buildCircle(
        all: 8,
        child: InkWell(
          onTap: () async {
            return onPressed();
          },
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 10,
          ),
        ),
        context: context,
      );

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
    required BuildContext context,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: context.primaryColor.withOpacity(0.9),
        child: child,
      ));
}

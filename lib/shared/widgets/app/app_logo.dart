import 'package:flutter/material.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/gen/assets.gen.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.height = 56,
    this.alignment = AlignmentDirectional.topStart,
    this.width = 96,
    this.changeColorModeOfText = false,
  });

  final double width;
  final double height;
  final AlignmentGeometry alignment;
  final bool changeColorModeOfText;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: SizedBox(
          key: const Key('app-logo-widget'),
          width: width,
          height: height,
          child: (changeColorModeOfText == true)
              ? Assets.svg.applogodark.svg(
                  alignment: AlignmentDirectional.topStart,
                )
              : Theme.of(context).brightness == Brightness.light
                  ? Assets.svg.applogo.svg(
                      alignment: AlignmentDirectional.topStart,
                    )
                  : Assets.svg.applogodark.svg(
                      alignment: AlignmentDirectional.topStart,
                    ),
        ),
      ),
    );
  }
}

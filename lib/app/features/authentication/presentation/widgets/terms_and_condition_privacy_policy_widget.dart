import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';

//import 'package:homemakers_merchant/config/translation/extension/string_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';

class TermsConditionStatementWidget extends StatelessWidget {
  const TermsConditionStatementWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        //padding: const EdgeInsetsDirectional.only(top: 5, bottom: 18, left: 30, right: 30),
        child: Center(
          child: Text.rich(
            TextSpan(
                text: 'By continuing, you agree to our ',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color.fromRGBO(127, 129, 132, 1),
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(
                        fontSize: 11,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(Routes.TERMS_AND_CONDITIONS);
                          return;
                        }),
                  TextSpan(
                      text: ' and ',
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              fontSize: 11,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // code to open / launch privacy policy link here
                                context.push(Routes.PRIVACY_AND_POLICY);
                                return;
                              })
                      ])
                ]),
            textAlign: TextAlign.center,
          ).translate(),
        ),
      ),
    );
  }
}

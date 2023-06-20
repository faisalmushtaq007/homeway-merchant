import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/config/translation/extension/string_extension.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';

class TermsConditionStatementWidget extends StatelessWidget {
  const TermsConditionStatementWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      //padding: const EdgeInsets.only(top: 5, bottom: 18, left: 30, right: 30),
      child: Center(
          child: Text.rich(
        TextSpan(
            text: 'By continuing, you agree to our '.tr(),
            style: const TextStyle(
              fontSize: 12,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: 'Terms of Service'.tr(),
                  style: const TextStyle(
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.push(Routes.TERMS_AND_CONDITIONS);
                      return;
                    }),
              TextSpan(
                  text: ' and '.tr(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Privacy Policy'.tr(),
                        style: const TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
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
      )),
    );
  }
}

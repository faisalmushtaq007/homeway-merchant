import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';

import 'package:homemakers_merchant/shared/widgets/universal/nil/src/nil.dart';

import 'package:homemakers_merchant/utils/app_log.dart';

class PhoneNumberValidateWidget extends StatefulWidget {
  const PhoneNumberValidateWidget({
    super.key,
    this.phoneNumberVerification = PhoneNumberVerification.none,
  });

  final PhoneNumberVerification phoneNumberVerification;

  @override
  _PhoneNumberValidateWidgetState createState() =>
      _PhoneNumberValidateWidgetState();
}

class _PhoneNumberValidateWidgetState extends State<PhoneNumberValidateWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: switch (widget.phoneNumberVerification.name) {
        'valid' => const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
        'invalid' => const Icon(
            Icons.error,
            color: Colors.red,
          ),
        _ => nil,
      },
    );
  }
}

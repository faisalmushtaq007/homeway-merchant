import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/bank/bank_info_tile_model.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';

class BankInformationTileWidget extends StatelessWidget {
  const BankInformationTileWidget({
    required this.bankInfoTile,
    super.key,
  });

  final BankInfoTile bankInfoTile;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        children: [
          Text(
            bankInfoTile.label,
            style: context.labelLarge!.copyWith(
              color: const Color.fromRGBO(165, 166, 168, 1),
            ),
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            bankInfoTile.content,
            style: context.labelMedium!.copyWith(
              color: const Color.fromRGBO(42, 45, 50, 1),
            ),
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

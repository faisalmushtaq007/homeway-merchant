import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/widgets/primary_dashboard_drawer.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/app/app_logo.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animate_do/animate_do.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/constrained_scrollable_views/constrained_scrollable_views.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:go_router/go_router.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({required this.storeEntity, super.key});

  final StoreEntity storeEntity;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        children: [
          Card(
            key: ValueKey(storeEntity.storeID),
            margin: const EdgeInsetsDirectional.only(bottom: 10, top: 5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
            child: ListTile(
              //dense: true,
              //leading: storeEntity.leading,
              title: Text(
                storeEntity.storeName,
                style: context.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ),
              subtitle: Text(
                storeEntity.storeAddress?.address?.area ?? '',
                style: context.labelMedium,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ),
              trailing: InkWell(
                onTap: () {
                  return;
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

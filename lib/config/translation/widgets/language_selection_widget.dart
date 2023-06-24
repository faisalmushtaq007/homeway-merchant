import 'package:flutter/material.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/src/widgets/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/one_context/one_context.dart';

class LanguageSelectionWidget extends StatefulWidget {
  const LanguageSelectionWidget({super.key});

  @override
  State<LanguageSelectionWidget> createState() =>
      _LanguageSelectionWidgetState();
}

class _LanguageSelectionWidgetState extends State<LanguageSelectionWidget> {
  void showLanguageBottomSheet() {
    OneContext().showBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return ListenableBuilder(
          listenable: serviceLocator<LanguageController>(),
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsetsDirectional.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Select Preferred Language',
                  ).translate(),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: GlobalApp.defaultLanguages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          if (serviceLocator<LanguageController>()
                                  .targetAppLanguage ==
                              GlobalApp
                                  .defaultLanguages[index].sourceLanguage) {
                            return;
                          } else {
                            // Change target language
                            serviceLocator<LanguageController>()
                                .changeTargetLanguage(
                              GlobalApp.defaultLanguages[index],
                            );
                          }
                          await Future.delayed(
                            const Duration(milliseconds: 300),
                            () {},
                          ).then((value) => Navigator.of(context).pop());

                          // Close bottom sheet
                        },
                        leading: ClipOval(
                          child: GlobalApp.defaultLanguages[index].image.svg(
                            height: 32,
                            width: 32,
                          ),
                        ),
                        title: Text(GlobalApp.defaultLanguages[index].text),
                        trailing: GlobalApp.defaultLanguages[index] ==
                                serviceLocator<LanguageController>()
                                    .targetAppLanguage
                            ? Icon(
                                Icons.check_circle_rounded,
                                color: Theme.of(context).primaryColorLight,
                              )
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: GlobalApp.defaultLanguages[index] ==
                                  serviceLocator<LanguageController>()
                                      .targetAppLanguage
                              ? BorderSide(
                                  color: Theme.of(context).primaryColorLight,
                                  width: 1.5,
                                )
                              : BorderSide(color: Colors.grey[300]!),
                        ),
                        tileColor: GlobalApp.defaultLanguages[index] ==
                                serviceLocator<LanguageController>()
                                    .targetAppLanguage
                            ? Theme.of(context)
                                .primaryColorLight
                                .withOpacity(0.05)
                            : null,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('click');
        return showLanguageBottomSheet();
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /*Text(
            serviceLocator<LanguageController>().targetAppLanguage.text,
            style: context.labelLarge,
          ),
          SizedBox(width: 8),
          */
          Icon(
            Icons.language,
          ),
        ],
      ),
    );
    return Material(
      child: OutlinedButton.icon(
        onPressed: () {
          debugPrint('click');
          return showLanguageBottomSheet();
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
        ),
        label: Icon(
          Icons.language,
        ),
        icon: Text(
          serviceLocator<LanguageController>().targetAppLanguage.text,
          style: context.labelLarge,
        ),
      ),
    );
  }
}

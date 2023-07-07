import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
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
import 'package:homemakers_merchant/shared/widgets/universal/double_tap_exit/double_tap_to_exit.dart';

class PrimaryDashboardDrawer extends StatelessWidget {
  const PrimaryDashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "Thomas Shelby",
                  style: TextStyle(fontSize: 18),
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                accountEmail: Text("thomashomeservice@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "T",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  ).translate(), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            /*ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(
                ' Profile ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            )

            ListTile(
              leading: const Icon(Icons.history),
              title: Text(
                ' History ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),*/
            ListTile(
              leading: const Icon(Icons.analytics),
              title: Text(
                ' Analysis & Monitoring ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: Text(
                ' Orders ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: Text(
                ' Payment ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: Text(
                ' Stores ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: Text(
                ' Menu ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                ' Settings ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_reaction_sharp),
              title: Text(
                ' Invite a Friend ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            /* ListTile(
              leading: const Icon(Icons.info),
              title: Text(
                ' Faq ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),*/
            ListTile(
              leading: const Icon(Icons.help),
              title: Text(
                ' Help & Support ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_sharp),
              title: Text(
                ' Privacy & Policy ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                ' LogOut ',
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ).translate(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

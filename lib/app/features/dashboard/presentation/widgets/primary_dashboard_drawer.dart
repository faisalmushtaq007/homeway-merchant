import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:homemakers_merchant/base/widget_view.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/common/drawer/drawer_entity.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/app/app_logo.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animate_do/animate_do.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/conditional_rendering/flutter_conditional_rendering.dart';
import 'package:homemakers_merchant/shared/widgets/universal/constrained_scrollable_views/constrained_scrollable_views.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/shared/widgets/universal/double_tap_exit/double_tap_to_exit.dart';

class PrimaryDashboardDrawer extends StatefulWidget {
  const PrimaryDashboardDrawer({super.key});

  @override
  _PrimaryDashboardDrawerController createState() => _PrimaryDashboardDrawerController();
}

class _PrimaryDashboardDrawerController extends State<PrimaryDashboardDrawer> {
  List<DrawerEntity> drawerEntities = [];

  @override
  void initState() {
    super.initState();
    drawerEntities = [];
    drawerEntities.clear();
    if (mounted) {
      initializeDrawerMenu(context);
    }
  }

  void initializeDrawerMenu(BuildContext context) {
    drawerEntities = [
      DrawerEntity(
        drawerID: 0,
        drawerName: 'Profile',
        hasExpanded: true,
        leading: const Icon(Icons.settings),
        controller: ExpansionTileController(),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        onPressed: () {
          return Navigator.of(context).pop();
        },
        children: [
          DrawerEntity(
            drawerID: 01,
            drawerName: 'My Profile',
            leading: const Icon(Icons.person),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 02,
            drawerName: 'Theme',
            leading: const Icon(Icons.dark_mode),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 03,
            drawerName: 'Language',
            leading: const Icon(Icons.language),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 04,
            drawerName: 'Notification',
            leading: const Icon(Icons.notifications),
            onPressed: () async {
              Navigator.of(context).pop();
              await context.push(Routes.NOTIFICATIONS);
              return;
            },
          ),
          DrawerEntity(
            drawerID: 05,
            drawerName: 'Rate & Review',
            leading: const Icon(Icons.rate_review),
            onPressed: () async {
              Navigator.of(context).pop();
              await context.push(Routes.RATE_AND_REVIEW_PAGE);
              return;
            },
          ),
        ],
      ),
      DrawerEntity(
        drawerID: 1,
        drawerName: 'Orders',
        leading: const Icon(Icons.book),
        hasExpanded: true,
        controller: ExpansionTileController(),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        onPressed: () {
          return Navigator.of(context).pop();
        },
        children: [
          DrawerEntity(
            drawerID: 10,
            drawerName: 'New Orders',
            leading: const Icon(Icons.book),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 11,
            drawerName: 'Track Current Orders',
            leading: const Icon(Icons.track_changes),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 12,
            drawerName: 'Order based on stores',
            leading: const Icon(Icons.storefront),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 13,
            drawerName: 'History',
            leading: const Icon(Icons.history),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
        ],
      ),
      DrawerEntity(
        drawerID: 2,
        drawerName: 'Stores',
        leading: const Icon(Icons.store),
        onPressed: () async {
          Navigator.of(context).pop();
          await context.push(Routes.ALL_STORES_PAGE);
          return;
        },
      ),
      DrawerEntity(
        drawerID: 3,
        drawerName: 'Menu',
        leading: const Icon(Icons.restaurant_menu),
        onPressed: () async {
          Navigator.of(context).pop();
          await context.push(Routes.ALL_MENU_PAGE);
          return;
        },
      ),
      DrawerEntity(
        drawerID: 4,
        drawerName: 'Drivers',
        leading: const Icon(Icons.payment),
        controller: ExpansionTileController(),
        onPressed: () async {
          Navigator.of(context).pop();
          await context.push(Routes.ALL_DRIVER_PAGE);
          return;
        },
      ),
      DrawerEntity(
        drawerID: 5,
        drawerName: 'Wallet',
        hasExpanded: true,
        leading: const Icon(Icons.payment),
        controller: ExpansionTileController(),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        onPressed: () {
          return Navigator.of(context).pop();
        },
        children: [
          DrawerEntity(
            drawerID: 50,
            drawerName: 'My Wallet',
            leading: const Icon(Icons.account_balance_wallet),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 51,
            drawerName: 'Manage Bank Account',
            leading: const Icon(Icons.account_balance),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 52,
            drawerName: 'History',
            leading: const Icon(Icons.history),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
        ],
      ),
      DrawerEntity(
        drawerID: 6,
        drawerName: 'Analysis and Monitoring',
        leading: const Icon(Icons.analytics),
        onPressed: () {
          return Navigator.of(context).pop();
        },
      ),
      DrawerEntity(
        drawerID: 7,
        drawerName: 'Invite a Friend',
        leading: const Icon(Icons.add_reaction_sharp),
        onPressed: () {
          return Navigator.of(context).pop();
        },
      ),
      DrawerEntity(
        drawerID: 8,
        drawerName: 'Help & Support',
        hasExpanded: true,
        leading: const Icon(Icons.help),
        controller: ExpansionTileController(),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        onPressed: () {
          return Navigator.of(context).pop();
        },
        children: [
          DrawerEntity(
            drawerID: 80,
            drawerName: 'FAQ',
            leading: const Icon(Icons.help),
            onPressed: () async {
              Navigator.of(context).pop();
              await context.push(Routes.FAQ_PAGE);
              return;
            },
          ),
          DrawerEntity(
            drawerID: 81,
            drawerName: 'Submit Your Query',
            leading: const Icon(Icons.query_builder),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 82,
            drawerName: 'Privacy and Policy',
            leading: const Icon(Icons.privacy_tip_sharp),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
          DrawerEntity(
            drawerID: 83,
            drawerName: 'Chat with us',
            leading: const Icon(Icons.chat),
            onPressed: () {
              return Navigator.of(context).pop();
            },
          ),
        ],
      ),
      DrawerEntity(
        drawerID: 9,
        drawerName: 'Logout',
        leading: const Icon(Icons.logout),
        onPressed: () {
          return Navigator.of(context).pop();
        },
      ),
    ];
  }

  @override
  void dispose() {
    drawerEntities = [];
    drawerEntities.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _PrimaryDashboardDrawerView(this);
}

class _PrimaryDashboardDrawerView extends WidgetView<PrimaryDashboardDrawer, _PrimaryDashboardDrawerController> {
  const _PrimaryDashboardDrawerView(super.state);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  //color: Colors.green,
                  ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                //decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "Thomas Shelby",
                  style: context.titleLarge!.copyWith(),
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                accountEmail: Text("thomashomeservice@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: Text(
                    "T",
                    style: context.titleMedium!.copyWith(),
                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  ).translate(), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ),
            for (final DrawerEntity drawerEntity in state.drawerEntities) buildDrawerTiles(context, drawerEntity),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerTiles(BuildContext context, DrawerEntity drawerEntity) {
    return Conditional.single(
      context: context,
      conditionBuilder: (BuildContext context) => drawerEntity.hasExpanded,
      widgetBuilder: (BuildContext context) => ExpansionTile(
        key: PageStorageKey<DrawerEntity>(drawerEntity),
        maintainState: true,
        leading: drawerEntity.leading,
        controller: drawerEntity.controller,
        expandedCrossAxisAlignment: drawerEntity.expandedCrossAxisAlignment,
        title: Text(
          drawerEntity.drawerName,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
        ).translate(),
        children: drawerEntity.children.map<Widget>((DrawerEntity entity) => buildDrawerTiles(context, entity)).toList().cast<Widget>(),
      ),
      fallbackBuilder: (BuildContext context) => ListTile(
        leading: drawerEntity.leading,
        onTap: drawerEntity.onPressed,
        title: Text(
          drawerEntity.drawerName,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
        ).translate(),
      ),
    );
  }
}

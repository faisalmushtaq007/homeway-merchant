import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_makers_customer_cli/app/controllers/auth_controller.dart';
import 'package:home_makers_customer_cli/app/core/commons/base/presentation/widgets/animated_gap/src/widgets/animated_gap.dart';
import 'package:home_makers_customer_cli/app/core/theme/app_colors.dart';
import 'package:home_makers_customer_cli/app/core/values/colors.dart';
import 'package:home_makers_customer_cli/app/modules/address/data/models/adddress_model.dart';
import 'package:home_makers_customer_cli/app/modules/settings/views/widget/common_account_widget.dart';
import '../../saved_address_index.dart';
import 'dart:math' as math;

class SavedAddressPage extends GetView<SavedAddressController> {
  SavedAddressPage({Key? key}) : super(key: key);
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Address")),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
          //height: MediaQuery.of(context).size.height,
          //width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth,
            minHeight: constraints.maxHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Common user profile widget
              Obx(() {
                var currentUser = authController.user;
                return CommonAccountInfoWidget(
                  currentUser: currentUser,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                );
              }),
              Expanded(
                child: GetBuilder<SavedAddressController>(
                    init: SavedAddressController(),
                    builder: (savedAddressController) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Actual page
                          /* DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ColorName.gray838,
                                ),
                              ),
                            ),
                            child: ListTileTheme(
                              contentPadding: EdgeInsets.zero,
                              minVerticalPadding: 2,
                              horizontalTitleGap: 0,
                              child: ListTile(
                                title: const Text('Add new address'),
                                onTap: savedAddressController.addNewAddress,
                                trailing: const Icon(Icons.arrow_forward_ios),
                                //visualDensity: VisualDensity(vertical: 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),*/
                          Flexible(
                            flex: 2,
                            fit: FlexFit.loose,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.98,
                              width: MediaQuery.of(context).size.width,
                              child: GetX<SavedAddressController>(
                                init: Get.put<SavedAddressController>(
                                    SavedAddressController()),
                                initState: (_) {},
                                builder: (SavedAddressController
                                    listSavedAddressController) {
                                  return ImplicitlyAnimatedList<AddressModel>(
                                    items:
                                        listSavedAddressController.savedAddress,
                                    areItemsTheSame: (a, b) =>
                                        a.addressRefId == b.addressRefId,
                                    itemBuilder:
                                        (context, animation, model, index) {
                                      final String? building =
                                          model.address?.apartment;
                                      final String? area = model.address?.area;
                                      final String? landmark =
                                          model.address?.landmark;
                                      final String? city = model.address?.city;
                                      final String? district =
                                          model.address?.district;
                                      final String? postalcode =
                                          model.address?.postalCode?.toString();
                                      final String? state =
                                          model.address?.state;
                                      final String? country =
                                          model.address?.country;
                                      final bool? isDefaultAddress =
                                          model?.isDefault;
                                      final String? saveAddressAs =
                                          model.address?.savedAddressAs;
                                      final String? selectedMapAddress =
                                          model.address?.displayAddressName;
                                      final listOfAddressElements = <String?>[
                                        building,
                                        landmark,
                                        area,
                                        city,
                                        district,
                                        postalcode,
                                        state,
                                        country
                                      ];
                                      listOfAddressElements.removeWhere(
                                          (element) =>
                                              element == null ||
                                              element.isEmpty);
                                      final sb = StringBuffer();
                                      sb.writeAll(listOfAddressElements, ", ");
                                      return SizeFadeTransition(
                                        sizeFraction: 0.7,
                                        curve: Curves.easeInOut,
                                        animation: animation,
                                        child: InkWell(
                                          key: ObjectKey(model),
                                          onTap: () {
                                            savedAddressController
                                                .onCardPressed(model);
                                            return;
                                          },
                                          child: Card(
                                            child: ClipRRect(
                                              clipBehavior: Clip.antiAlias,
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                12.0, 8, 12, 8),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Text(
                                                              '${saveAddressAs}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        17,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                              softWrap: true,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                            Text(
                                                              '${model.fullName}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        16,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                              softWrap: true,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                            Text(
                                                              'Phone: ${model.phoneNumber ?? ''}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        15,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                              softWrap: true,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                            ),
                                                            AnimatedGap(
                                                              2,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          250),
                                                            ),
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: sb
                                                                        .toString(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displaySmall!
                                                                        .copyWith(
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              12,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: true,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      AnimatedGap(
                                                        2,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    250),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Row(
                                                          //mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            TextButton(
                                                              onPressed: () {
                                                                savedAddressController
                                                                    .editAddress(
                                                                        model);
                                                                return;
                                                              },
                                                              style: TextButton
                                                                  .styleFrom(
                                                                      //foregroundColor: kMainColor,
                                                                      ),
                                                              child:
                                                                  Text('Edit'),
                                                            ),
                                                            TextButton(
                                                                onPressed: () {
                                                                  String?
                                                                      warningMessage;
                                                                  if (model.isDefault !=
                                                                          null &&
                                                                      model.isDefault ==
                                                                          true) {
                                                                    warningMessage =
                                                                        "This address which you want to remove is your default address, So first select any one of your address as default then delete it again.";
                                                                  }
                                                                  savedAddressController
                                                                      .removeAddress(
                                                                          model,
                                                                          description:
                                                                              warningMessage);
                                                                  return;
                                                                },
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  foregroundColor:
                                                                      kMainColor,
                                                                ),
                                                                child: Text(
                                                                    'Remove')),
                                                            AnimatedCrossFade(
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          1000),
                                                              crossFadeState: (isDefaultAddress ==
                                                                      true)
                                                                  ? CrossFadeState
                                                                      .showFirst
                                                                  : CrossFadeState
                                                                      .showSecond,
                                                              firstChild:
                                                                  const Offstage(),
                                                              secondChild:
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        savedAddressController
                                                                            .setDefaultAddress(
                                                                          model,
                                                                        );
                                                                      },
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                              //foregroundColor: kMainColor,
                                                                              ),
                                                                      child: Text(
                                                                          'Set as Default')),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  if (isDefaultAddress == true)
                                                    Positioned(
                                                      top: 0,
                                                      left: savedAddressController
                                                                  .bannerPositionRight ==
                                                              false
                                                          ? 0
                                                          : null,
                                                      right: savedAddressController
                                                                      .bannerPositionRight ==
                                                                  true ||
                                                              savedAddressController
                                                                      .bannerPositionRight ==
                                                                  null
                                                          ? 0
                                                          : null,
                                                      child: ClipPath(
                                                        clipper: BannerClipper(
                                                            savedAddressController
                                                                .bannerPositionRight),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: savedAddressController
                                                                    .bannerColor ??
                                                                const Color(
                                                                    0xffcf0517),
                                                          ),
                                                          height: savedAddressController
                                                                      .bannersize ==
                                                                  null
                                                              ? 40
                                                              : savedAddressController
                                                                          .bannersize! >=
                                                                      80
                                                                  ? 80
                                                                  : savedAddressController
                                                                              .bannersize! <=
                                                                          40
                                                                      ? 40.0
                                                                      : savedAddressController
                                                                          .bannersize!, //40
                                                          width: savedAddressController
                                                                      .bannersize ==
                                                                  null
                                                              ? 40
                                                              : savedAddressController
                                                                          .bannersize! >=
                                                                      80
                                                                  ? 80
                                                                  : savedAddressController
                                                                              .bannersize! <=
                                                                          40
                                                                      ? 40.0
                                                                      : savedAddressController
                                                                          .bannersize!,
                                                          child: Align(
                                                            alignment:
                                                                savedAddressController
                                                                            .bannerPositionRight ==
                                                                        false
                                                                    ? Alignment
                                                                        .topLeft
                                                                    : Alignment
                                                                        .topRight,
                                                            child: Transform
                                                                .rotate(
                                                              angle: savedAddressController
                                                                          .bannerPositionRight ==
                                                                      false
                                                                  ? -math.pi / 4
                                                                  : math.pi / 4,
                                                              child: SizedBox(
                                                                height: savedAddressController
                                                                            .bannersize ==
                                                                        null
                                                                    ? 30
                                                                    : savedAddressController.bannersize! >=
                                                                            80
                                                                        ? (30.0 *
                                                                                80.0) /
                                                                            40.0
                                                                        : savedAddressController.bannersize! <=
                                                                                40
                                                                            ? (30.0 * 40.0) /
                                                                                40.0
                                                                            : (30.0 * savedAddressController.bannersize!) /
                                                                                40.0, //30
                                                                width: savedAddressController
                                                                            .bannersize ==
                                                                        null
                                                                    ? 30
                                                                    : savedAddressController.bannersize! >=
                                                                            80
                                                                        ? (30.0 *
                                                                                80.0) /
                                                                            40.0
                                                                        : savedAddressController.bannersize! <=
                                                                                40
                                                                            ? (30.0 * 40.0) /
                                                                                40.0
                                                                            : (30.0 * savedAddressController.bannersize!) /
                                                                                40.0,
                                                                child: FittedBox(
                                                                    alignment: Alignment.center,
                                                                    fit: BoxFit.contain,
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.only(right: 2, top: 2, left: 2, bottom: 4),
                                                                        child: Text(
                                                                          "Default",
                                                                          style:
                                                                              TextStyle(color: Colors.yellow),
                                                                        ))),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    // An optional builder when an item was removed from the list.
                                    // If not specified, the List uses the itemBuilder with
                                    // the animation reversed.
                                    removeItemBuilder:
                                        (context, animation, oldItem) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: Card(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                  '${oldItem.address?.savedAddressAs}'),
                                              Text('${oldItem.address?.city}'),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              GetBuilder<SavedAddressController>(
                  init: SavedAddressController(),
                  builder: (savedAddressController) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 0.0),
                      child: ElevatedButton(
                        onPressed: () {
                          savedAddressController.addNewAddress();
                          return;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kMainColor,
                          foregroundColor: Colors.white,
                          fixedSize: Size(Get.width, 46),
                        ),
                        child: Text(
                          'Add new address',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        );
      }),
    );
  }
}

class BannerClipper extends CustomClipper<Path> {
  final bool? side;

  BannerClipper(this.side);

  @override
  Path getClip(Size size) {
    var path = Path();

    if (side == null || side == true) {
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else {
      path.lineTo(size.width, 0);
      path.lineTo(0, size.height);
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

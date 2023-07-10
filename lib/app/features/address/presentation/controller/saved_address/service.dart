import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_makers_customer_cli/app/core/commons/base/presentation/base_controller.dart';
import 'package:home_makers_customer_cli/app/core/commons/widgets/dialog/blurry/blurry.dart';
import 'package:home_makers_customer_cli/app/core/commons/widgets/dialog/blurry/resources/arrays.dart';
import 'package:home_makers_customer_cli/app/core/theme/app_colors.dart';

class DialogService extends Blurry {
  ///the dialog popup title, required in all blurry class constructors
  final String title;

  ///the dialog description text
  ///required in all blurry class constructors
  final String description;

  ///the cancel button text, by default  it's 'Cancel'
  late String cancelButtonText = '';

  ///the confirm button (primary button) text string
  late String confirmButtonText = '';

  ///the dialog theme color
  ///will be applied on buttons and icon
  ///not available in default types constructors (info, error, warning, success)
  late Color? themeColor;

  ///function invoked when the primary button is pressed
  ///required in all constructors
  late Function? onConfirmButtonPressed;

  ///the callback that will be invoked when pressing on cancel button
  late Function? onCancelButtonPressed;

  ///the icon that will be rendered in the dialog
  ///required only when using the default constructor
  late IconData? icon;

  ///title text style, by default it's null
  final TextStyle? titleTextStyle;

  ///description text style, by default it's null
  final TextStyle? descriptionTextStyle;

  ///button text style, by default it's null
  final TextStyle? buttonTextStyle;

  ///the blurry dialog popup height
  final double? popupHeight;

  ///indicate whether the cancel button will be rendered or not
  ///by default the cancel button is displayed
  late bool displayCancelButton;

  ///indicates whether the popup dialog is dismissable or not
  ///by default [dismissable = true]
  final bool dismissable;

  ///the color of the barrier of the burry dialog
  ///if it's null the barrier color will be the default color [Colors.black54]
  final Color? barrierColor;

  ///the layout rendering type, LTR, RTL or center
  ///possible values
  /// - ltr
  /// - rtl
  /// - center
  /// by default is [LayoutType.ltr]
  final LayoutType layoutType;

  /// the input label string, required when using the input constructor
  late String? inputLabel;

  /// the input text field text controller
  /// required when using the input constructor
  late TextEditingController? inputTextController;

  /// the input text style by default it's just black text
  late TextStyle inputTextStyle;

  /// the input label style by default it's just black text
  late TextStyle inputLabelStyle;

  /// text input type applied on input field
  /// available only when using the input constructor
  late TextInputType textInputType;

  /// the design type of the popup, available when using input constructor
  /// availabele options
  /// ```dart
  /// {
  /// info,
  /// success,
  /// error,
  /// warning
  /// }
  /// ```
  late DefaultThemes? defaultTheme;

  /// indicate whether display visibility eye icon on password fields
  /// available only when using `Blurry.password` constructor
  /// by default it's 'true'
  bool withVisibilityEye = true;

  ///list items that will be rendered in the single selector blurry popup type
  ///available only when using `singleChoiceSelector` constructor (should be not null and not empty)
  late List<Widget>? items;

  ///invoked when pressing on item from the list
  ///available only when using `singleChoiceSelector`
  ///by default pressing an element from the list will close the popup
  late Function(int)? onItemSelected;

  late TYPE? dialogType;

  bool isPasswordField = false;

  DialogService({
    this.title = 'Info',
    this.description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididuntut labore et dolore magna aliqua. Ut enim ad minim veniam',
    this.cancelButtonText = 'Cancel',
    this.confirmButtonText = 'Confirm',
    this.themeColor,
    this.onConfirmButtonPressed,
    this.onCancelButtonPressed,
    this.icon,
    this.titleTextStyle,
    this.descriptionTextStyle,
    this.buttonTextStyle,
    this.popupHeight,
    this.displayCancelButton = true,
    this.dismissable = true,
    this.barrierColor,
    this.layoutType = LayoutType.ltr,
    this.inputLabel,
    this.inputTextController,
    this.defaultTheme,
    this.withVisibilityEye = true,
    this.items,
    this.onItemSelected,
    this.dialogType,
    this.isPasswordField = false,
  }) : super(
          title: title,
          description: description,
          themeColor: themeColor,
          confirmButtonText: confirmButtonText,
          onConfirmButtonPressed: onConfirmButtonPressed,
          icon: icon,
          titleTextStyle: titleTextStyle,
          descriptionTextStyle: descriptionTextStyle,
          buttonTextStyle: buttonTextStyle,
          popupHeight: popupHeight,
          displayCancelButton: displayCancelButton,
          dismissable: dismissable,
          barrierColor: barrierColor,
          layoutType: layoutType,
          inputLabel: inputLabel,
          inputTextController: inputTextController,
          cancelButtonText: cancelButtonText,
          onCancelButtonPressed: onCancelButtonPressed,
        );

  void showInfo(
      {required String title,
      required String description,
      Color? themeColor,
      required Function? onConfirmButtonPressed,
      Function? onCancelButtonPressed,
      double popupHeight = 300,
      Key? key,
      String? confirmButtonText}) {
    Blurry.info(
      title: title,
      description: description,
      confirmButtonText: confirmButtonText ?? 'Confirm',
      titleTextStyle: Get.textTheme.titleLarge!.copyWith(color: Colors.black87),
      popupHeight: popupHeight,
      buttonTextStyle: Get.textTheme.titleMedium,
      descriptionTextStyle: Get.textTheme.bodyMedium!
          .copyWith(fontWeight: FontWeight.w500, fontSize: 12.5),
      onConfirmButtonPressed: onConfirmButtonPressed,
      key: key,
      themeColor: themeColor,
      onCancelButtonPressed: onCancelButtonPressed ??
          () {
            //Get.back(closeOverlays: true);
          },
    ).show(Get.context!);
    return;
  }

  void showWarning(
      {required String title,
      required String description,
      Color? themeColor,
      required Function? onConfirmButtonPressed,
      Function? onCancelButtonPressed,
      double popupHeight = 300,
      Key? key}) {
    Blurry.warning(
      title: title,
      description: description,
      confirmButtonText: 'Ok',
      titleTextStyle: Get.textTheme.titleLarge!.copyWith(color: Colors.black87),
      popupHeight: popupHeight,
      buttonTextStyle: Get.textTheme.titleMedium,
      descriptionTextStyle: Get.textTheme.bodyMedium!
          .copyWith(fontWeight: FontWeight.w500, fontSize: 12.5),
      onConfirmButtonPressed: onConfirmButtonPressed,
      key: key,
      themeColor: themeColor,
      onCancelButtonPressed: onCancelButtonPressed ??
          () {
            //Get.back(closeOverlays: true);
            //return;
          },
    ).show(Get.context!);
    return;
  }

  void showError(
      {required String title,
      required String description,
      Color? themeColor,
      required Function? onConfirmButtonPressed,
      double popupHeight = 300,
      Key? key}) {
    Blurry.error(
      title: title,
      description: description,
      confirmButtonText: 'Ok',
      titleTextStyle: Get.textTheme.titleLarge!.copyWith(color: Colors.black87),
      popupHeight: popupHeight,
      buttonTextStyle: Get.textTheme.titleMedium,
      descriptionTextStyle: Get.textTheme.bodyMedium!
          .copyWith(fontWeight: FontWeight.w500, fontSize: 12.5),
      onConfirmButtonPressed: onConfirmButtonPressed,
      key: key,
      themeColor: themeColor,
      onCancelButtonPressed: () {
        //Get.back(closeOverlays: true);
        //return;
      },
    ).show(Get.context!);
    return;
  }

  void showSuccess(
      {required String title,
      required String description,
      Color? themeColor,
      required Function? onConfirmButtonPressed,
      double popupHeight = 300,
      Key? key}) {
    Blurry.success(
      title: title,
      description: description,
      confirmButtonText: 'Ok',
      titleTextStyle: Get.textTheme.titleLarge!.copyWith(color: Colors.black87),
      popupHeight: popupHeight,
      buttonTextStyle: Get.textTheme.titleMedium,
      descriptionTextStyle: Get.textTheme.bodyMedium!
          .copyWith(fontWeight: FontWeight.w500, fontSize: 12.5),
      onConfirmButtonPressed: onConfirmButtonPressed,
      key: key,
      themeColor: themeColor,
      onCancelButtonPressed: () {
        //Get.back(closeOverlays: true);
        //return;
      },
    ).show(Get.context!);
    return;
  }
}

import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/bank/common_dialog_properties.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';

// copied from flutter calendar picker
const Duration _dialogSizeAnimationDuration = Duration(milliseconds: 200);
// Constants
const double kPickerHeaderPortraitHeight = 45.0;
const double kPickerHeaderLandscapeWidth = 160.0;
const double kDialogActionBarHeight = 50.0;
const double kDialogMargin = 20.0;

///Is dialog showing
bool isShowing = false;

Future<T?> showConfirmationDialog<T extends Object?>({
  required BuildContext context,
  bool barrierDismissible = false,
  required WidgetBuilder builder,
  Curve curve = Curves.linear,
  Duration? duration,
  Alignment alignment = Alignment.center,
  Color? barrierColor,
  Axis? axis = Axis.horizontal,
}) {
  assert(debugCheckHasMaterialLocalizations(context));

  final ThemeData theme = Theme.of(context);
  isShowing = true;

  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        top: false,
        child: Builder(builder: (BuildContext context) {
          return Theme(data: theme, child: pageChild);
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: barrierColor ?? Colors.black54,
    transitionDuration: duration ?? const Duration(milliseconds: 400),
    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

/// This is a support widget that returns an Dialog with checkboxes as a Widget.
/// It is designed to be used in the showDialog method of other fields.
class ResponsiveDialog extends StatefulWidget
    implements ICommonDialogProperties {
  ResponsiveDialog({
    super.key,
    required this.context,
    String? title,
    Widget? child,
    this.headerColor,
    this.headerTextColor,
    this.backgroundColor,
    this.buttonTextColor,
    this.forcePortrait = false,
    double? maxLongSide,
    double? maxShortSide,
    this.hideButtons = false,
    this.okPressed,
    this.cancelPressed,
    this.confirmText,
    this.cancelText,
    this.cancelButtonVisible = true,
  })  : title = title ?? "Title Here",
        child = child ?? Text("Content Here"),
        maxLongSide = maxLongSide ?? 600,
        maxShortSide = maxShortSide ?? 400;

  // Variables
  final BuildContext context;
  @override
  final String? title;
  final Widget child;
  final bool forcePortrait;
  @override
  final Color? headerColor;
  @override
  final Color? headerTextColor;
  @override
  final Color? backgroundColor;
  @override
  final Color? buttonTextColor;
  @override
  final double? maxLongSide;
  @override
  final double? maxShortSide;
  final bool hideButtons;
  @override
  final String? confirmText;
  @override
  final String? cancelText;
  final bool cancelButtonVisible;

  // Events
  final VoidCallback? cancelPressed;
  final VoidCallback? okPressed;

  @override
  _ResponsiveDialogState createState() => _ResponsiveDialogState();
}

class _ResponsiveDialogState extends State<ResponsiveDialog> {
  late Color _headerColor;
  late Color? _headerTextColor;
  late Color _backgroundColor;
  late Color? _buttonTextColor;

  Widget header(BuildContext context, Orientation orientation) {
    return Container(
      height: (orientation == Orientation.portrait)
          ? kPickerHeaderPortraitHeight
          : null,
      width: (orientation == Orientation.landscape)
          ? kPickerHeaderLandscapeWidth
          : null,
      padding: const EdgeInsetsDirectional.only(
        top: 20,
        start: 12,
        end: 4,
        bottom: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        children: [
          Text(
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
            widget.title!,
            style: context.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget actionBar(BuildContext context, EdgeInsetsGeometry? padding) {
    if (widget.hideButtons) return Container();

    var localizations = MaterialLocalizations.of(context);

    return Container(
      height: kDialogActionBarHeight,
      padding: padding,
      child: ButtonBar(
        mainAxisSize: MainAxisSize.min,
        alignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (widget.cancelButtonVisible)
            ElevatedButton(
              key: const Key('confirm-dialog-negative-button'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(238, 238, 238, 1),
                textStyle: context.labelLarge,
              ),
              child: Text(
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                widget.cancelText ?? localizations.cancelButtonLabel,
                style: context.labelLarge!.copyWith(
                  color: Color.fromRGBO(127, 129, 132, 1.0),
                ),
              ),
              onPressed: () => (widget.cancelPressed == null)
                  ? Navigator.of(context).pop()
                  : widget.cancelPressed!(),
            )
          else
            const SizedBox.shrink(),
          ElevatedButton(
            key: const Key('confirm-dialog-positive-button'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(69, 201, 125, 1),
                textStyle: context.labelLarge,
                minimumSize: const Size(120, 36)),
            child: Text(
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              widget.confirmText ?? localizations.okButtonLabel,
              style: context.labelLarge!.copyWith(
                color: Colors.white,
              ),
              //style: TextStyle(color: _buttonTextColor),
            ),
            onPressed: () => (widget.okPressed == null)
                ? Navigator.of(context).pop()
                : widget.okPressed!(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    _headerColor = widget.headerColor ?? theme.primaryColor;
    _headerTextColor =
        widget.headerTextColor ?? theme.primaryTextTheme.titleLarge?.color;
    _buttonTextColor =
        widget.buttonTextColor ?? theme.textTheme.labelLarge?.color;
    _backgroundColor = widget.backgroundColor ?? theme.dialogBackgroundColor;

    final Orientation orientation = MediaQuery.of(context).orientation;

    // constrain the dialog from expanding to full screen
    final Size dialogSize = Size(widget.maxShortSide!, widget.maxLongSide!);
/*    final Size dialogSize = (orientation == Orientation.portrait)
        ? Size(widget.maxShortSide!, widget.maxLongSide!)
        : Size(widget.maxLongSide!, widget.maxShortSide!);*/

    return Dialog(
      backgroundColor: _backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(16),
      ),
      child: Directionality(
        key: const Key('confirm-dialog-directionality'),
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: AnimatedContainer(
          width: dialogSize.width,
          height: dialogSize.height,
          alignment: Alignment.topLeft,
          duration: _dialogSizeAnimationDuration,
          constraints: BoxConstraints.tightFor(
            height: dialogSize.height,
            width: dialogSize.width,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //header(context, orientation),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 20,
                  start: 20,
                  end: 20,
                  bottom: 16,
                ),
                child: Row(
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    Text(
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                      widget.title!,
                      style: context.titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20,
                  ),
                  child: widget.child,
                ),
              ),
              actionBar(
                context,
                const EdgeInsetsDirectional.symmetric(
                  horizontal: 14,
                ),
              ),
            ],
          ),
          /*child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              if (widget.forcePortrait) orientation = Orientation.portrait;

              switch (orientation) {
                case Orientation.portrait:
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      //header(context, orientation),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 20,
                          start: 20,
                          end: 20,
                          bottom: 20,
                        ),
                        child: Row(
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          children: [
                            Text(
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                              widget.title!,
                              style: context.titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 20,
                          ),
                          child: widget.child,
                        ),
                      ),
                      actionBar(
                        context,
                        const EdgeInsetsDirectional.symmetric(
                          horizontal: 14,
                        ),
                      ),
                    ],
                  );
                case Orientation.landscape:
                  return Row(
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      header(context, orientation),
                      Flexible(
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
                          children: <Widget>[
                            Flexible(
                              child: widget.child,
                            ),
                            actionBar(context,
                                EdgeInsetsDirectional.symmetric(horizontal: 8)),
                          ],
                        ),
                      ),
                    ],
                  );
              }
            },
          ),*/
        ),
      ),
    );
  }
}

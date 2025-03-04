import 'package:flutter/material.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/shared/widgets/universal/one_context/src/components/one_context_widget.dart';
import 'package:homemakers_merchant/shared/widgets/universal/one_context/src/controllers/dialog_controller.mixin.dart';
import 'package:homemakers_merchant/shared/widgets/universal/one_context/src/controllers/navigator_controller.mixin.dart';
import 'package:homemakers_merchant/shared/widgets/universal/one_context/src/controllers/overlay_controller.mixin.dart';

class OneContext with NavigatorController, OverlayController, DialogController {
  static BuildContext? _context;

  /// The almost top root context of the app,
  /// use it carefully or don't use it directly!
  BuildContext? get context {
    assert(_context != null, NO_CONTEXT_ERROR);
    return _context;
  }

  static bool get hasContext => _context != null;

  set context(BuildContext? newContext) => _context = newContext;

  /// If you need reactive changes, do not use OneContext().mediaQuery
  /// Use `MediaQuery.of(context)` instead.
  MediaQueryData get mediaQuery => MediaQuery.of(context!);

  /// If you need reactive changes, do not use OneContext().theme
  /// Use `Theme.of(context)` instead.
  ThemeData get theme => Theme.of(context!);

  /// If you need reactive changes, do not use OneContext().textTheme
  /// Use `Theme.of(context).textTheme` instead.
  TextTheme get textTheme => theme.textTheme;

  FocusScopeNode get focusScope => FocusScope.of(context!);

  /// Locale
  Locale get locale => Localizations.localeOf(context!);

  HeroController heroController = HeroController(
      createRectTween: (begin, end) =>
          MaterialRectCenterArcTween(begin: begin, end: end));

  OneContext._private() {}

  static OneContext instance = OneContext._private();

  factory OneContext() => instance;

  /// Register all necessary callbacks from main widget, automatically
  void registerDialogCallback({
    Future<T?> Function<T>({
      required Widget Function(BuildContext) builder,
      bool? barrierDismissible,
      bool useRootNavigator,
      Color? barrierColor,
      String? barrierLabel,
      bool useSafeArea,
      RouteSettings? routeSettings,
      Offset? anchorPoint,
    })? showDialog,
    Future<T?> Function<T>({
      required Widget Function(BuildContext) builder,
      Color? backgroundColor,
      double? elevation,
      ShapeBorder? shape,
      Clip? clipBehavior,
      bool? isScrollControlled,
      bool? useRootNavigator,
      bool? isDismissible,
      BoxConstraints? constraints,
      Color? barrierColor,
      bool? enableDrag,
      RouteSettings? routeSettings,
      AnimationController? transitionAnimationController,
      Offset? anchorPoint,
    })? showModalBottomSheet,
    ScaffoldFeatureController<SnackBar, SnackBarClosedReason> Function(
            SnackBar Function(BuildContext?) builder)?
        showSnackBar,
    PersistentBottomSheetController<T> Function<T>({
      Widget Function(BuildContext)? builder,
      Color? backgroundColor,
      double? elevation,
      ShapeBorder? shape,
      Clip? clipBehavior,
      BoxConstraints? constraints,
      bool? enableDrag,
      AnimationController? transitionAnimationController,
    })? showBottomSheet,
  }) {
    registerCallback(
        showDialog: showDialog,
        showSnackBar: showSnackBar,
        showModalBottomSheet: showModalBottomSheet,
        showBottomSheet: showBottomSheet);
  }

  /// Use [OneContext().builder] in MaterialApp builder,
  /// in order to show dialogs and overlays.
  ///
  /// e.g.
  ///
  /// ```dart
  /// return MaterialApp(
  ///       builder: OneContext().builder,
  ///      ...
  /// ```
  Widget builder(
    BuildContext context,
    Widget? widget, {
    Key? key,
    MediaQueryData? mediaQueryData,
    String? initialRoute,
    Route<dynamic> Function(RouteSettings)? onGenerateRoute,
    Route<dynamic> Function(RouteSettings)? onUnknownRoute,
    List<NavigatorObserver> observers = const <NavigatorObserver>[],
  }) =>
      Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: ParentContextWidget(
          child: widget,
          mediaQueryData: mediaQueryData,
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute,
          onUnknownRoute: onUnknownRoute,
          observers: [OneContext().heroController], //observers,
        ),
      );
}

class ParentContextWidget extends StatelessWidget {
  final MediaQueryData? mediaQueryData;
  final String? initialRoute;
  final Route<dynamic> Function(RouteSettings)? onGenerateRoute;
  final Route<dynamic> Function(RouteSettings)? onUnknownRoute;
  final List<NavigatorObserver> observers;
  final Widget? child;

  const ParentContextWidget(
      {Key? key,
      this.child,
      this.mediaQueryData,
      this.initialRoute,
      this.onGenerateRoute,
      this.onUnknownRoute,
      this.observers = const <NavigatorObserver>[]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQueryData ?? MediaQuery.of(context),
      child: Navigator(
        initialRoute: initialRoute,
        onUnknownRoute: onUnknownRoute,
        observers: observers,
        onGenerateRoute: onGenerateRoute ??
            (settings) => MaterialPageRoute(
                builder: (context) => OneContextWidget(
                      child: child,
                    )),
      ),
    );
  }
}

const String NO_CONTEXT_ERROR = """
  OneContext not initiated! please use builder method.
  You need to use the OneContext().builder function to be able to show dialogs and overlays! e.g. ->

  MaterialApp(
    builder: OneContext().builder,
    ...
  )

  If you already set the OneContext().builder early, maybe you are probably trying to use some methods that will only be available after the first MaterialApp build.
  OneContext needs to be initialized by MaterialApp before it can be used in the application. This error exception occurs when OneContext context has not yet loaded and you try to use some method that needs the context, such as the showDialog, dismissSnackBar, showSnackBar, showModalBottomSheet, showBottomSheet or popDialog methods.

  If you need to use any of these OneContext methods before defining the MaterialApp, a safe way is to check if the OneContext context has already been initialized.
  e.g. 

  ```dart
    if (OneContext.hasContext) {OneContext().showDialog (...);}
  ```
""";

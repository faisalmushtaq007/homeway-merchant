import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language.dart';
import 'package:homemakers_merchant/gen/assets.gen.dart';

// ignore_for_file: comment_references

/// App static functions and constants used in the example applications.
///
/// In a real app you probably prefer putting these into different static
/// classes that serves your application's usage. For these examples I
/// put them all in the same class, except the colors that are in their
/// own class.
class GlobalApp {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  GlobalApp._();

  // Info about the app.

  /// Returns the title of the MaterialApp.
  ///
  /// Used to set title on pages to
  /// same one that is defined in each example as its app name. Handy as we only
  /// need to update in one place, where it belongs and no need to put it as
  /// a const somewhere and no need to pass it around via a title prop either.
  /// Also used in the [showAppAboutDialog] About box as app name.
  static String title(BuildContext context) =>
      (context as Element).findAncestorWidgetOfExactType<MaterialApp>()!.title;

  // When building new public web versions of the demos, make sure to
  // update this info with current versions used for the build, before
  // triggering GitHub actions CI/CD that builds them.
  //
  // The name of the package this app demonstrates.
  static const String packageName = 'homemakers_merchant';

  // Version of the WEB build, usually same as package, but it also has a
  // build numbers.
  static const String versionMajor = '1';
  static const String versionMinor = '0';
  static const String versionPatch = '0';
  static const String versionBuild = '1';
  static const String version = '$versionMajor.$versionMinor.$versionPatch '
      'Build-$versionBuild';
  static const String packageVersion =
      '$versionMajor.$versionMinor.$versionPatch';
  static const String flutterVersion = 'stable';
  static const String copyright = '© 2023 - 2024';
  static const String author = '';
  static const String license = '';
  static const String icon = '';

  /// The max dp width used for layout content on the screen in the available
  /// body area.
  ///
  /// Wider content gets growing side padding, kind of like on most
  /// web pages when they are used on super wide screen. This is typically used
  /// pages in the example apps that use content that is width constrained,
  /// typically via the [PageBody] screen content wrapper widget.
  static const double maxBodyWidth = 1000;

  /// Breakpoint needed to show second panel in side-by-side view for the
  /// [ThemeTopicPage] page view.
  ///
  /// This is available content layout width, not media size!
  ///
  /// This min width was chosen because it gives at least the primary, secondary
  /// and tertiary colors in one Wrap row on panels Input Colors and Seeded
  /// ColorScheme, also when the side-by-side code view appears.
  static const double sideBySideViewBreakpoint = 760;

  /// The minimum media size needed for desktop/large tablet menu view,
  /// this is media size.
  ///
  /// Only at higher than this breakpoint will the menu expand from rail and
  /// be possible to toggle between menu and rail. Below this breakpoint it
  /// toggles between hidden in the Drawer and being a Rail, also on phones.
  /// This size was chosen because in combination codeViewWidthBreakpoint, it
  /// gives us a breakpoint where we get code side by side view in desktop
  /// rail mode already, and when it switches to menu mode, the desktop is
  /// wide enough to show both the full width menu and keep showing the
  /// code in side-by-side view. We could do lower the desktop width breakpoint,
  /// but then that view switches temporarily to now showing the code view,
  /// and it is just to much dynamic changes happening, it does not nice.
  static const double desktopWidthBreakpoint = 1700;

  /// A medium sized desktop, in panel view we switch to vertical
  /// topic selector page [ThemeTwoTopicsPage], with topic selector on
  /// left and right side, one for each theme topic panel.
  ///
  /// This is a media size breakpoint.
  static const double mediumDesktopWidthBreakpoint = 1079;

  /// This breakpoint is only used to further increase margins and insets on
  /// very large desktops.
  static const double bigDesktopWidthBreakpoint = 2800;

  /// The minimum media width treated as a phone device in this app.
  static const double phoneWidthBreakpoint = 600;

  /// The minimum media height treated as a phone device in this app.
  static const double phoneHeightBreakpoint = 700;

  /// Edge insets and margins for phone breakpoint size.
  static const double edgeInsetsPhone = 8;

  /// Edge insets and margins for tablet breakpoint size.
  static const double edgeInsetsTablet = 12;

  /// Edge insets and margins for desktop and medium desktop breakpoint sizes.
  static const double edgeInsetsDesktop = 18;

  /// Edge insets and margins for big desktop breakpoint size.
  static const double edgeInsetsBigDesktop = 24;

  /// Responsive insets based on width.
  ///
  /// The width may be from LayoutBuilder or
  /// MediaQuery, depending on what is appropriate for the use case.
  static double responsiveInsets(double width, [bool isCompact = false]) {
    if (width < phoneWidthBreakpoint || isCompact) return edgeInsetsPhone;
    if (width < desktopWidthBreakpoint) return edgeInsetsTablet;
    if (width < bigDesktopWidthBreakpoint) return edgeInsetsDesktop;
    return edgeInsetsBigDesktop;
  }

  /// The height when we want to pin the panel or color selector, instead of
  /// letting it float and snap back.
  static const double pinnedSelector = 1090;

  /// The width, and height of the scrolling panel buttons in Themes Playground
  /// page view, and how much it shrinks when we go to phone size.
  ///
  /// The same shrunk sizes are reused in the compact view mode in larger
  /// breakpoints, when the compact view mode is selected.
  static const double panelButtonWidth = 115;
  static const double panelButtonHeight = 100;
  static const double panelButtonPhoneWidthReduce = -20;
  static const double panelButtonPhoneHeightReduce = -30;

  /// The width and height reduction of input color selection box in phone size.
  ///
  /// The same shrunk size is reused in the compact view mode in larger
  /// breakpoints, when the compact view mode is selected.
  static const double colorButtonPhoneReduce = -12;

  // Get the main font that is used in some of the examples.
  // Feel free to try different fonts.
  // For demonstration purposes the custom font is defined via Google fonts
  // both as its fontFamily name and its TextTheme. In the playground we pass
  // the textTheme to fontFamily and the textTheme to both textTheme and
  // primaryTextTheme. You can remove either the fontFamily or the
  // textTheme/primaryTextTheme usage and it will still work fine.
  // FlexColorScheme will also sort out the right text theme contrasts for
  // light and dark themes and for the primaryTextTheme to always have right
  // contrast for whatever primary color is used. FlexColorScheme also retains
  // the correct opacities on text style if M2 Typography is used, and removes
  // it from style when M3 Typography is used.
  static String? get font => GoogleFonts.poppins().fontFamily;

  static TextTheme get textTheme => GoogleFonts.poppinsTextTheme();

  /// Defining the visual density here to so we can change it in one spot when
  /// we want to try different options.
  ///
  /// Use what you prefer, I just like this one on desktop better than the
  /// default one. The default Flutter one is too dense imo.
  static VisualDensity get visualDensity =>
      FlexColorScheme.comfortablePlatformDensity;
  static const int developmentPort = 5000;
  static const int productionPort = 5000;
  static const String developmentBaseUrl = '15.184.169.237';
  static const String productionBaseUrl = '15.184.169.237';
  static const String baseApiPath = 'merchant/api/';
  static const String apiVersion = 'v1';

  //merchant/api/v1
  static String merchantApiPath =
      [GlobalApp.baseApiPath, GlobalApp.apiVersion].join('/').toString();

  // Development URL
  static String developmentUrl = Uri(
    scheme: 'http',
    host: developmentBaseUrl,
    port: developmentPort,
    path: merchantApiPath,
  ).toString();

  // Development URL
  static String productionUrl = Uri(
    scheme: 'https',
    host: productionBaseUrl,
    port: productionPort,
    path: merchantApiPath,
  ).toString();

  static const String userModelKey = 'userModelKey';
  static AppUserEntity defaultUserModel = serviceLocator<AppUserEntity>();
  static const String userAccessTokenKey = 'userAccessToken';
  static String defaultUserAccessToken =
      serviceLocator<AppUserEntity>().access_token ?? '';
  static const String defaultMessageDuringLoading =
      'Please wait while we are fetching';
  static const String defaultSomethingWentWrong =
      'Something went wrong, please try again later';
  static const String defaultFailure = 'Failure';

  static final defaultLanguages = <Language>[
    Language(
      const Locale('en', 'US'),
      Assets.svg.flags.gb,
      'English',
      TranslateLanguage.english,
      textDirection: TextDirection.ltr,
    ),
    /*Language(
        const Locale('sd', 'SA'),
        Assets.svg.flags.sa,
        'Arabic',
        TranslateLanguage.arabic,
      ),
      Language(
        const Locale('hi', 'IN'),
        Assets.svg.flags.ind,
        'Hindi',
        TranslateLanguage.hindi,
      ),
      Language(
        const Locale('hi-Latn', 'IN'),
        Assets.svg.flags.ind,
        'Hindi-Latin',
        TranslateLanguage.hindi,
      ),*/
    Language(
      const Locale('ar', 'SA'),
      Assets.svg.flags.sa,
      'Arabic',
      TranslateLanguage.arabic,
      textDirection: TextDirection.rtl,
    ),
  ];

  // Key used to read and save the keyLanguage value.
  static const String keyLanguage = 'sourceAppLanguage';
  static const String keyTargetAppLanguage = 'targetAppLanguage';
  static final Language defaultLanguageSelect = defaultLanguages[0];
  static final Language defaultTargetLanguageSelect = defaultLanguages[0];
  static const String keySourceTranslateLanguage = 'sourceTranslateLanguage';
  static TranslateLanguage defaultSourceTranslateLanguage =
      defaultLanguages[0].sourceLanguage;
  static const String keyTargetTranslateLanguage = 'targetTranslateLanguage';
  static TranslateLanguage defaultTargetTranslateLanguage =
      defaultLanguages[0].sourceLanguage;
  static const String permissionBoxName = 'permission_box';
  static const String storageBoxName = 'user_model_box';
  static const String languageBoxName = 'user_language_box';
  static const String translationBoxName = 'user_translation_box';
  static const String keyTargetLocale = 'targetLocale';
  static const String keySourceLocale = 'sourceLocale';
  static Locale defaultTargetLocale = defaultLanguages[0].value;
  static Locale defaultSourceLocale = defaultLanguages[0].value;
  static const String keyTargetTextDirection = 'targetTextDirection';
  static final TextDirection defaultTargetTextDirection =
      defaultLanguages[0].textDirection;

  static final defaultDocumentPickerSource = [
    DocumentPickerSource.camera,
    DocumentPickerSource.gallery,
    DocumentPickerSource.folder,
    DocumentPickerSource.none,
  ];
  static final String productionInstanceName = 'production';
  static final String developmentInstanceName = 'development';
  static final String localhostInstanceName = 'localhost';
  static final String stagingInstanceName = 'staging';
  static final String addressCollection = '/address';
  static final String storeCollection = '/store';
  static final String menuCollection = '/menu';
  static final String driverCollection = '/driver';
  static final String businessCollection = '/business';
  static final String profileCollection = '/profile';
  static final String addonsCollection = '/addons';
  static final String userTypeCollection = '/usertype';
}

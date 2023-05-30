import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/constants/flex_tone.dart';
import 'package:homemakers_merchant/core/constants/store.dart';
import 'package:homemakers_merchant/theme/theme_controller.dart';

import 'code_theme.dart';
import 'theme_color_scheme.dart';

// For our custom color scheme we define primary and secondary colors,
// but no container or other colors.
final FlexSchemeColor _schemeLight = flexSchemeLight as FlexSchemeColor;

// These are custom defined matching dark mode colors. Further below we show
// how to compute them based on the light color scheme. You can swap them in the
// code example further below and compare the result of these manually defined
// matching dark mode colors, to the ones computed via the "lazy" designer
// matching dark colors.
final FlexSchemeColor _schemeDark = flexSchemeDark as FlexSchemeColor;
// To use a pre-defined color scheme, don't assign any FlexSchemeColor to
// `colors` instead, just pick a FlexScheme enum based value and assign it
// to the `scheme`. Try eg the new "flutterDash" color scheme, based on colors
// found in the 4k wallpaper Google shared before the Flutter 2.10.0 release.
const FlexScheme _scheme = FlexScheme.amber;
// Made for FlexColorScheme version 7.1.0. Make sure you
// use same or higher package version, but still same major version.
// If you use a lower version, some properties may not be supported.
// In that case remove them after copying this theme to your app.
// To make it easy to toggle between using the above custom colors, or the
// selected predefined scheme in this example, set _useScheme to true to use the
// selected predefined scheme above, set it to false to use the custom colors
// defined earlier above.
const bool _useScheme = true;

// A quick setting for the themed app bar elevation, it defaults to 0.
// A very low, like 0.5 is pretty nice too, since it gives an underline effect
// visible with e.g. white or light colored app bars.
const double _appBarElevation = 0.5;

// There is setting to put an opacity value on the app bar. If used, we can see
// content scroll behind it, if we also extend the Scaffold behind the AppBar.
const double _appBarOpacity = 0.94;

// If you set _computeDarkTheme below to true, the dark scheme will be computed
// both for the selected scheme and the custom colors, from the light scheme.
// There is a bit of logic hoops below to make it happen via this bool toggle.
//
// Going "toDark()" on your light FlexSchemeColor definition is just a quick
// way you can make a dark scheme from a light color scheme definition, without
// figuring out usable color values yourself. This is useful during development,
// when you test custom colors. For production and final colors you probably
// want to fine tune your custom dark color scheme colors and use const values.
const bool _computeDarkTheme = false;

// When you use _computeDarkTheme, use this de-saturation % level to calculate
// the dark scheme from the light scheme colors. The default is 35%, but values
// from 20% might work on less saturated light scheme colors. For more
// deep and colorful starting values, you can try 40%. Trivia: The default
// red dark error color in the Material design guide, is computed from the light
// theme error color value, by using 40% with the same algorithm used here.
const int _toDarkLevel = 30;

// To swap primary and secondary colors, set to true. With some color schemes
// interesting and even useful inverted primary-secondary themes can be obtained
// by only swapping the colors on your dark scheme. Some schemes where even
// designed with this usage in mind, but not all look so well when using it.
const bool _swapColors = false;

// The `usedColors` is a convenience property that allows you to vary which
// colors to use of the primary, secondary and variant colors included in
// `colors` in `FlexSchemeColor`, or the `FlexSchemeColor` the enum based
// selection specifies. The integer number corresponds to using:
//
// * 1 = Only the primary color
// * 2 = Primary & Secondary colors
// * 3 = Primary + container & Secondary colors
// * 4 = Primary + container & Secondary + container
// * 5 = Primary + container & Secondary + container & tertiary colors
// * 6 = Primary + container & Secondary + container & tertiary + container
// * 7 = PST, Primary, Secondary and Tertiary, containers computed.
//
// This can be a quick way to try what you theme looks like when using less
// source colors and just different shades of the same color, that are still
// correctly tuned for their ColorScheme color values.
//
// The values default to 6, so that any color values that are defined are always
// used as defined and given.
const int _usedColors = 6;

// New in version 5: Key color seed based theming.
//
// If you want to use Material 3 based seed generated color schemes, using
// the current FlexColorScheme's colors as input to the seed generation. You
// can do so by passing in just a default `FlexKeyColors()` object to the
// `keyColors` property in FlexColorScheme.light and .dark factories.
//
// FlexKeyColors can be also configured, if its `useKeyColors` is false it is
// no being used, likewise it is not if the property `keyColors` is null.
//
// The default constructor `FlexKeyColors()` has the properties `useKeyColors`,
// `useSecondary` and `useTertiary` defaulting to true. This means the primary,
// secondary and tertiary colors from your active FlexColorScheme's colors will
// all be used as key colors to generate the theme's ColorScheme.
//
// The primary color is always using useKeyColors is true, but using secondary
// and tertiary colors to generate the ColorScheme are optional.
// They are on by default in the default constructor, to omit them set any
// of them to false.
//
// Flutter SDK `ColorScheme.fromSeed` only accepts a/ single color,
// the main/primary color as a seed color for the Material 3 ColorScheme
// it generates from a seed color. If you set both `useSecondary`
// and `useTertiary` to false, the result is the same as if you would have
// provided the current primary color value from the active FlexColorScheme
// to `ColorScheme.fromSeed` to generate the theme used `ColorScheme`.
// When you also use secondary and tertiary colors as input to generate the
// ColorScheme, their color values are based on them, instead of being sourced
// in fixed manner from the single primary color. This makes the generated
// ColorScheme follow the colors in your specified keys to a larger degree
// than Flutter SDK `ColorScheme.fromSeed` does.
//
// When you use seeded ColorSchemes, the key color used as seed color as primary
// color, secondary and tertiary usually do not end up in the resulting
// ColorScheme. This can be problematic when your spec calls for a specific
// specific e.g. brand color for certain color properties.
//
// With FlexColorscheme you can, for e.g. branding or other purposes, decide to
// keep one or more of the defined color values in your FlexColorScheme at its
// defined color value, despite otherwise using seeded color values to produce
// the resulting `ColorScheme`from them. There is a `keep` toggle in
// `FlexKeyColors` for all the six main colors in a `ColorScheme`, you can
// set any of them to true, to keep the color in question it has as input
// in your FlexColorScheme.
const FlexKeyColors _keyColors = FlexKeyColors(
  useKeyColors: false, // <-- set to true enable M3 seeded ColorScheme.
  useSecondary: true,
  useTertiary: true,
  keepPrimary: false, // <-- Keep defined value, do not use the seeded result.
  keepPrimaryContainer: false,
  keepSecondary: false,
  keepSecondaryContainer: false,
  keepTertiary: false,
  keepTertiaryContainer: false,
);

// New in version 5: Custom configuration for seed color calculations.
//
// Not only does FlexColorScheme enable using more than one seed color, you
// can also completely customize the tone mapping and CAM16 chroma limits
// imposed on used seed generation algorithm.
//
// When using Material 3 design and key colors, it generates 6 different tonal
// palettes `TonalPalette` for the colors in a M3 ColorScheme:
//
// * Primary tonal palette
// * Secondary tonal palette
// * Tertiary tonal palette
// * Error tonal palette
// * Neutral tonal palette
// * Neutral variant tonal palette
//
// Each palette contains 13 colors starting from black and ending in white, with
// different "tones" in-between of the color used for the palette.
// ColorScheme.from generates all the palettes from a single input color, and
// a hard coded value for the error palettes. FlexColorScheme allows you to as
// seen also specify the input colors for secondary and tertiary tonal palette.
// The neutral palettes are also generated from the input primary color, but
// with very little chroma of it left it, a bit more in the variant palette.
// this is a bit like the surface alpha blend that FlexColorScheme has
// been using since its first version.
//
// The algorithm used by ColorScheme.from also lock chroma for secondary and
// tertiary to a given value, and primary is min 48, after tha it uses
// chroma from the provided color. When tonal palettes have been created, it
// uses fixed tones (indexes) from relevant tonal palette and assigns them
// to given color properties in the ColorScheme. It is also worth noticing
// to you should use the same key color for both dark and light theme mode.
// the algorithm uses the same tonal palette for light and dark modes, but
// different tones from same palette.
//
// FlexColorScheme opens up this algorithm and logic and enables you to
// modify the color seed logic and behavior. The used algorithm is really
// fascinating, and the M3 usage of it is fine too. But maybe you want to it
// produce colors that are even more earthy and softer than M3, that is pretty
// soft already. Maybe your want more vivid tones, more in classic M2 style, or
// perhaps you need to seed schemes with much higher contrast for accessibility
// reasons. With FlexColorScheme you can. You do this by making a custom
// FlexTones data class to configure how the seeding engine maps palette colors
// the ColorScheme and how it uses chroma values in the key colors.
//
// The `FlexTones` has a `FlexTones.light` and `FlexTones.dark` factory, that
// are used for respective theme mode when using key colors in FlexColorScheme
// by default.
//
// The `FlexTones.light` factory by default provides the same chroma limits and
// tone mappings as used by:
// `ColorScheme.fromSeed(seedColor: color, brightness: Brightness.light)`
//
// Likewise the `FlexTones.dark` corresponds to same chroma limits and tone
// mappings as used by:
// `ColorScheme.fromSeed(seedColor: color, brightness: Brightness.dark)`.
//
// However, with the factories you can customize which tone each ColorScheme
// color properties uses as its color from its corresponding tonal palette.
// You can also change if primary, secondary and tertiary colors use the
// chroma in their key color value, if it should have a at least a given
// minimum chroma value, and after that use the key color's chroma value,
// or if it should be locked to a given chroma value.
//
// There is also a static that returns a default FlexTones.light and
// FlexTones.dark, when you pass it a brightness, called FlexTones.material,
// to indicate that it is using the default Material 3 specification.
//
// There are few more pre-made static configurations, for example:
//
// * FlexTones.soft
// * FlexTones.vivid
// * FlexTones.highContrast
//
// You can swap in them in below to try slightly different styles on generated
// seeded ColorScheme. The `FlexTones.vivid` for example, keeps the chroma as is
// in key colors for secondary and tertiary, and will thus produce a seeded
// ColorScheme that is closer to the provided key/seed colors, than the Flutter
// SDK M3 spec version does.
final FlexTones _flexTonesLight = FlexTones.material(Brightness.light);
final FlexTones _flexTonesDark = FlexTones.material(Brightness.dark);

// Use a GoogleFonts font as default font for your theme.
//final String? _fontFamily = GoogleFonts.poppins().fontFamily;
String? get fontFamily => GoogleFonts.poppins().fontFamily;
TextTheme get textTheme => GoogleFonts.poppinsTextTheme();
// Define a custom text theme for the app. Here we have decided that
// display fonts are too big to be useful for us, so we make them a bit smaller
// and that labelSmall is a bit too small and has weird letter spacing, so we
// make it bigger and change its letter spacing.
const TextTheme _textTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 53),
  displayMedium: TextStyle(fontSize: 41),
  displaySmall: TextStyle(fontSize: 36),
  labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.5),
);

// FlexColorScheme before version 4 used a `surfaceStyle` property to
// define the surface color blend mode. Version 4, deprecated `surfaceStyle`
// and introduced `surfaceMode` and `blendLevel`. In version 5 the old
// `surfaceStyle` has been removed, thus in version 5 you have to change to
// using `surfaceMode` and `blendLevel` if you have not done so already.
//
// The `surfaceMode` takes `FlexSurfaceMode` that is used to select the used
// strategy for blending primary color into different surface colors.
const FlexSurfaceMode _surfaceMode = FlexSurfaceMode.highBackgroundLowScaffold;

// The alpha blend level strength can be defined separately from the
// SurfaceMode strategy, and has 40 alpha blend level strengths.
const int _blendLevel = 20;

// The `useSubThemes` sets weather you want to opt-in or not on additional
// opinionated sub-theming. By default FlexColorScheme as before does very
// little styling on widgets, other than a few important adjustments, described
// in detail in the readme. By using the sub-theme opt-in, it now also offers
// easy to use additional out-of the box opinionated styling of SDK UI Widgets.
// One key feature is the rounded corners on Widgets that support it.
const bool _useSubThemes = true;

// The opt-in opinionated sub-theming offers easy to use consistent corner
// radius rounding setting on all sub-themes and a ToggleButtons design that
// matches the normal buttons style and size.
// It comes with Material 3 like rounded defaults, but you can adjust
// its configuration via simple parameters in a passed in configuration class
// called FlexSubThemesData.
//
// Here are some some configuration examples:
const FlexSubThemesData _subThemesData = FlexSubThemesData(
  // Opt in for themed hover, focus, highlight and splash effects.
  // New buttons use primary themed effects by default, this setting makes
  // the general ThemeData hover, focus, highlight and splash match that.
  // True by default when opting in on sub themes, but you can turn it off.
  interactionEffects: true,

  // When it is null = undefined, the sub themes will use their default style
  // behavior that aims to follow new Material 3 (M3) standard for all widget
  // corner radius. Current Flutter SDK corner radius is 4, as defined by
  // the Material 2 design guide. M3 uses much higher corner radius, and it
  // varies by widget type.
  //
  // When you set [defaultRadius] to a value, it will override these defaults
  // with this global default. You can still set and lock each individual
  // border radius back for these widget sub themes to some specific value, or
  // to its Material3 standard, which is mentioned in each theme as the used
  // default when its value is null.
  //
  // Set global corner radius. Default is null, resulting in M3 styles, but make
  // it whatever you like, even 0 for a hip to be square style.
  defaultRadius: null,
  // You can also override individual corner radius for each sub-theme to make
  // it different from the global `cornerRadius`. Here eg. the bottom sheet
  // radius is defined to always be 24:
  bottomSheetRadius: 24,

  // Use the Material 3 like text theme. Defaults to true.
  useTextTheme: true,

  // Select input decorator type, only SDK options outline and underline
  // supported no, but custom ones may be added later.
  inputDecoratorBorderType: FlexInputBorderType.outline,
  // For a primary color tinted background on the input decorator set to true.
  inputDecoratorIsFilled: true,
  // If you do not want any underline/outline on the input decorator when it is
  // not in focus, then set this to false.
  inputDecoratorUnfocusedHasBorder: false,
  // Select the ColorScheme color used for input decoration border.
  // Primary is default so no need to set that, used here as placeholder to
  // enable easy selection of other options.
  inputDecoratorSchemeColor: SchemeColor.primary,
  // Set some alpha channel opacity value input decorator.
  inputDecoratorBackgroundAlpha: 20,

  // Some FAB (Floating Action Button) settings.
  //
  // // If fabUseShape is false, no shape will be added to FAB theme, it will get
  // // whatever default shape the widget default behavior applies.
  // //
  // fabUseShape: false,
  // //
  // // Select the ColorScheme color used by FABs as their base/background color
  // // Secondary is default so no need to set that, used here as placeholder to
  // // enable easy selection of other options.
  // //
  // fabSchemeColor: SchemeColor.secondaryContainer,

  // Select the ColorScheme color used by Chips as their base color
  // Primary is default so no need to set that, used here as placeholder to
  // enable easy selection of other options.
  chipSchemeColor: SchemeColor.primary,

  // Elevations have easy override values as well.
  elevatedButtonElevation: 1,
  // Widgets that use outline borders can be easily adjusted via these
  // properties, they affect the outline input decorator, outlined button and
  // toggle buttons.
  thickBorderWidth: 1.5, // Default is 2.0.
  thinBorderWidth: 1, // Default is 1.0.

  // Select the ColorScheme color used for selected TabBar indicator.
  // Defaults to same color as selected tab if not defined.
  // tabBarIndicatorSchemeColor: SchemeColor.secondary,

  // Select the ColorScheme color used for selected bottom navigation bar item.
  // Primary is default so no need to set that, used here as placeholder to
  // enable easy selection of other options.
  bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,

  // Select the ColorScheme color used for bottom navigation bar background.
  // Background is default so no need to set that, provided here as placeholder
  // to enable easy selection of other options.
  bottomNavigationBarBackgroundSchemeColor: SchemeColor.background,

  // Below are some example quick override properties that you can use on the
  // M3 based NavigationBar. The section is double commented out, so it its
  // easy to uncomment to try them all.
  //
  // // SchemeColor based color for [NavigationBar]'s selected item icon.
  // // navigationBarSelectedIconSchemeColor: SchemeColor.tertiary,
  // // SchemeColor based color for [NavigationBar]'s selected item label.
  // navigationBarSelectedLabelSchemeColor: SchemeColor.tertiary,
  // // SchemeColor based color for [NavigationBar]'s unselected item icons.
  // navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
  // // SchemeColor based color for [NavigationBar]'s unselected item icons.
  // navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
  // // SchemeColor based color for [NavigationBar]'s selected item highlight.
  // navigationBarIndicatorSchemeColor: SchemeColor.tertiaryContainer,
  // // If you use suitable M3 designed container color for the indicator, it
  // // does not need any opacity.
  // navigationBarIndicatorOpacity: 1,
  // // Select the ColorScheme color used for [NavigationBar]'s background.
  // navigationBarBackgroundSchemeColor: SchemeColor.background,
  // // When set to true [NavigationBar] unselected icons use a more muted
  // // version of color defined by [navigationBarUnselectedIconSchemeColor].
  // navigationBarMutedUnselectedIcon: true,
  // // When set to true [NavigationBar] unselected labels use a more muted
  // // version of color defined by [navigationBarUnselectedLabelSchemeColor].
  // navigationBarMutedUnselectedLabel: true,
  // // Set size of labels.
  // navigationBarSelectedLabelSize: 12,
  // navigationBarUnselectedLabelSize: 10,
  // // Set the size of icons icons.
  // navigationBarSelectedIconSize: 26,
  // navigationBarUnselectedIconSize: 22,
);

// If true, the top part of the Android AppBar has no scrim, it then becomes
// one colored like on iOS.
const bool _transparentStatusBar = true;

// Usually the TabBar is used in an AppBar. This style themes it right for
// that, regardless of what FlexAppBarStyle you use for the `appBarStyle`.
// If you will use the TabBar on Scaffold or other background colors, then
// use the style FlexTabBarStyle.forBackground.
const FlexTabBarStyle _tabBarForAppBar = FlexTabBarStyle.forAppBar;

// If true, tooltip background brightness is same as background brightness.
// False by default, which is inverted background brightness compared to theme.
// Setting this to true is more Windows desktop like.
const bool _tooltipsMatchBackground = true;

// The visual density setting defaults to same as SDK default value,
// which is `VisualDensity.adaptivePlatformDensity`. You can define a fixed one
// or try `FlexColorScheme.comfortablePlatformDensity`.
// The `comfortablePlatformDensity` is an alternative adaptive density to the
// default `adaptivePlatformDensity`. It makes the density `comfortable` on
// desktops, instead of `compact` as the `adaptivePlatformDensity` does.
// This is useful on desktop with touch screens, since it keeps tap targets
// a bit larger but not as large as `standard` intended for phones and tablets.
final VisualDensity _visualDensity = FlexColorScheme.comfortablePlatformDensity;

// This is just standard `platform` property in `ThemeData`, handy to have as
// a direct property, you can use it to test how things changes on different
// platforms without using `copyWith` on the resulting theme data.
final TargetPlatform _platform = defaultTargetPlatform;
final bool _useMaterial3ErrorColors = false;

/// A theme Extension example with a single custom brand color property.
///
/// You can add as many colors and other theme properties as you need, and
/// you can add multiple different ThemeExtension sub classes as well.
class BrandTheme extends ThemeExtension<BrandTheme> {
  const BrandTheme({
    this.brandColor,
  });
  final Color? brandColor;

  // You must override the copyWith method.
  @override
  BrandTheme copyWith({
    Color? brandColor,
  }) =>
      BrandTheme(
        brandColor: brandColor ?? this.brandColor,
      );

  // You must override the lerp method.
  @override
  BrandTheme lerp(ThemeExtension<BrandTheme>? other, double t) {
    if (other is! BrandTheme) {
      return this;
    }
    return BrandTheme(
      brandColor: Color.lerp(brandColor, other.brandColor, t),
    );
  }
}

// Custom const theme with our brand color in light mode.
const BrandTheme lightBrandTheme = BrandTheme(
  brandColor: Color.fromARGB(255, 8, 79, 71),
);

// Custom const theme with our brand color in dark mode.
const BrandTheme darkBrandTheme = BrandTheme(
  brandColor: Color.fromARGB(255, 167, 227, 218),
);
// Light theme Data
ThemeData lightTheme() {
  final Color source =
      flexColorSchemeLightTheme(Colors.black).toScheme.surfaceTint;
  return flexColorSchemeLightTheme(source).toTheme.copyWith(
        drawerTheme: DrawerThemeData(width: 360),
      );
}

FlexColorScheme flexColorSchemeLightTheme(Color source) {
  return FlexColorScheme.light(
    scheme: _scheme,
    surfaceMode: Store.defaultSurfaceModeLight,
    colorScheme: flexSchemeLight,
    blendLevel: Store.defaultBlendLevel,
    usedColors: Store.defaultUsedColors,
    colors: _useScheme ? null : _schemeLight,
    transparentStatusBar: Store.defaultTransparentStatusBar,
    appBarStyle: Store
        .defaultAppBarStyleLight, // Try different style, e.g.FlexAppBarStyle.primary,
    appBarElevation: Store.defaultAppBarElevationLight,
    appBarOpacity: Store.defaultAppBarOpacityLight,
    bottomAppBarElevation: Store.defaultBottomAppBarElevationLight,
    tabBarStyle: Store.defaultTabBarStyle,
    //darkIsTrueBlack: controller.darkIsTrueBlack,
    swapLegacyOnMaterial3: Store.defaultSwapLegacyColors,
    swapColors: Store.defaultSwapLightColors,
    tooltipsMatchBackground: Store.defaultTooltipsMatchBackground,
    subThemesData: FlexSubThemesData(
      blendOnLevel: Store.defaultBlendOnLevel,
      blendOnColors: Store.defaultBlendLightOnColors,
      useM2StyleDividerInM3: Store.defaultUseM2StyleDividerInM3,
      navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedLabel: Store.defaultNavBarMuteUnselected,
      navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedIcon: Store.defaultNavBarMuteUnselected,
      navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationBarIndicatorOpacity: 1.00,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: Store.defaultUseMaterial3,
    keyColors: _keyColors,
    useMaterial3ErrorColors: _useMaterial3ErrorColors,
    // Use predefined [FlexTones] setups for the generated
    // [TonalPalette] and it's usage in [ColorScheme] config.
    // You can make your custom [FlexTones] object right here
    // and apps it it, this just uses an int value to select
    // between a few pre-configured ones.
    tones: FlexTone.values[1]
        .tones(Brightness.light)
        .onMainsUseBW(Store.defaultOnMainsUseBWLight)
        .onSurfacesUseBW(Store.defaultOnSurfacesUseBWLight),
    // Use custom surface tint color.
    surfaceTint: Store.defaultSurfaceTintLight,
    //
    // Custom font, modify in App class to change it.
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
    fontFamily: GlobalApp.font,
    textTheme: GlobalApp.textTheme,
    primaryTextTheme: GlobalApp.textTheme,
    //
    // To test manual typography override use this:
    typography: Typography.material2021(platform: _platform),
    // Or the one below, the selection will correctly override the via
    // sub themes "useTextTheme" value.
    // typography: Typography.material2018(platform: controller.platform),
    //
    // The platform can be toggled in the app, but not saved.
    platform: _platform,
    // Add a custom theme extension with light mode code highlight colors.
    extensions: <ThemeExtension<dynamic>>{
      CodeTheme.harmonized(source, Brightness.light),
    },

// To use the playground font, add GoogleFonts package and uncomment
// fontFamily: GoogleFonts.notoSans().fontFamily,
  );
}

// Light theme Data
ThemeData darkTheme() {
  final Color source =
      flexColorSchemeDarkTheme(Colors.black).toScheme.surfaceTint;
  return flexColorSchemeDarkTheme(source).toTheme.copyWith(
        drawerTheme: DrawerThemeData(width: 360),
      );
}

FlexColorScheme flexColorSchemeDarkTheme(Color source) {
  return FlexColorScheme.dark(
    scheme: FlexScheme.amber,
    surfaceMode: Store.defaultSurfaceModeDark,
    colorScheme: flexSchemeLight,
    blendLevel: Store.defaultBlendLevelDark,
    usedColors: Store.defaultUsedColors,
    colors: _useScheme ? null : _schemeLight,
    transparentStatusBar: Store.defaultTransparentStatusBar,
    appBarStyle: Store
        .defaultAppBarStyleDark, // Try different style, e.g.FlexAppBarStyle.primary,
    appBarElevation: Store.defaultAppBarElevationDark,
    appBarOpacity: Store.defaultAppBarOpacityDark,
    bottomAppBarElevation: Store.defaultBottomAppBarElevationDark,
    tabBarStyle: Store.defaultTabBarStyle,
    //darkIsTrueBlack: controller.darkIsTrueBlack,
    swapLegacyOnMaterial3: Store.defaultSwapLegacyColors,
    swapColors: Store.defaultSwapDarkColors,
    tooltipsMatchBackground: Store.defaultTooltipsMatchBackground,
    subThemesData: FlexSubThemesData(
      blendOnLevel: Store.defaultBlendOnLevelDark,
      blendOnColors: Store.defaultBlendDarkOnColors,
      useM2StyleDividerInM3: Store.defaultUseM2StyleDividerInM3,
      navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedLabel: Store.defaultNavBarMuteUnselected,
      navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedIcon: Store.defaultNavBarMuteUnselected,
      navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationBarIndicatorOpacity: 1.00,
    ),

    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: Store.defaultUseMaterial3,
    keyColors: _keyColors,
    useMaterial3ErrorColors: _useMaterial3ErrorColors,
    // Use predefined [FlexTones] setups for the generated
    // [TonalPalette] and it's usage in [ColorScheme] config.
    // You can make your custom [FlexTones] object right here
    // and apps it it, this just uses an int value to select
    // between a few pre-configured ones.
    tones: FlexTone.values[1]
        .tones(Brightness.dark)
        .onMainsUseBW(Store.defaultOnMainsUseBWDark)
        .onSurfacesUseBW(Store.defaultOnSurfacesUseBWDark),
    // Use custom surface tint color.
    surfaceTint: Store.defaultSurfaceTintDark,
    //
    // Custom font, modify in App class to change it.
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
    fontFamily: GlobalApp.font,
    textTheme: GlobalApp.textTheme,
    primaryTextTheme: GlobalApp.textTheme,
    //
    // To test manual typography override use this:
    typography: Typography.material2021(platform: _platform),
    // Or the one below, the selection will correctly override the via
    // sub themes "useTextTheme" value.
    // typography: Typography.material2018(platform: controller.platform),
    //
    // The platform can be toggled in the app, but not saved.
    platform: _platform,
    // Add a custom theme extension with light mode code highlight colors.
    extensions: <ThemeExtension<dynamic>>{
      CodeTheme.harmonized(source, Brightness.dark),
    },
  );
}
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,

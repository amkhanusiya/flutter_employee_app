import 'package:dynamic_color/dynamic_color.dart';
import 'package:employee_app/theme/text/app_typography.dart';
import 'package:employee_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color/app_color_scheme.dart';
import 'text/app_text_theme.dart';

Future<ThemeData> createTheme({
  Color? color,
  required Brightness brightness,
}) async {
  final colorScheme = _getColorScheme(color: color, brightness: brightness);
  final dynamicColorScheme = await _getDynamicColors(brightness: brightness);
  final appColorScheme = _getAppColorScheme(
    color: color,
    colorScheme: colorScheme,
    dynamicColorScheme: dynamicColorScheme,
    brightness: brightness,
  );

  final appTypography =
      AppTypography.create(fontFamily: $constants.theme.defaultFontFamily);
  final textTheme =
      _getTextTheme(appTypography: appTypography, brightness: brightness);

  final primaryColor = ElevationOverlay.colorWithOverlay(
      appColorScheme.surface, appColorScheme.primary, 3);
  final customOnPrimaryColor = appColorScheme.primary.withOpacity(0.5);

  return ThemeData(
    textTheme: textTheme.materialTextTheme,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: appColorScheme.materialColorScheme,
    brightness: appColorScheme.brightness,
    typography: appTypography.materialTypography,
    useMaterial3: true,
    toggleableActiveColor: customOnPrimaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: $constants.theme.defaultThemeColor,
      foregroundColor: $constants.palette.white,
      elevation: $constants.theme.defaultElevation,
      titleTextStyle: textTheme.materialTextTheme.titleLarge!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: $constants.palette.white,
      ),
      systemOverlayStyle: createOverlayStyle(
        brightness: brightness,
        primaryColor: primaryColor,
      ),
    ),
    splashFactory: InkRipple.splashFactory,
    scaffoldBackgroundColor: appColorScheme.surface,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: $constants.theme.defaultElevation,
      backgroundColor: $constants.theme.defaultThemeColor,
      highlightElevation: $constants.theme.defaultElevation,
    ),
    iconTheme: IconThemeData(
      color: appColorScheme.primary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          textTheme.labelLarge.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor:
            MaterialStateProperty.all<Color>($constants.palette.lightBlue),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        foregroundColor: MaterialStateProperty.all(
          $constants.theme.defaultThemeColor,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          textTheme.labelLarge.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          $constants.theme.defaultThemeColor,
        ),
        foregroundColor: MaterialStateProperty.all(
          $constants.palette.white,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    ),
    cardTheme: CardTheme(
      elevation: $constants.theme.defaultElevation,
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            $constants.theme.defaultBorderRadius,
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: $constants.theme.defaultBorderWidth,
          color: $constants.palette.borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: $constants.theme.defaultBorderWidth,
          color: $constants.palette.borderColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: $constants.theme.defaultBorderWidth,
          color: $constants.palette.red,
        ),
      ),
      errorMaxLines: 2,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: $constants.theme.defaultBorderWidth,
          color: $constants.palette.borderColor,
        ),
      ),
    ),
  );
}

SystemUiOverlayStyle createOverlayStyle({
  required Brightness brightness,
  required Color primaryColor,
}) {
  final isDark = brightness == Brightness.dark;

  return SystemUiOverlayStyle(
    systemNavigationBarColor: primaryColor,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
  );
}

Future<ColorScheme?> _getDynamicColors({required Brightness brightness}) async {
  try {
    final corePalette = await DynamicColorPlugin.getCorePalette();

    return corePalette?.toColorScheme(brightness: brightness);
  } on PlatformException {
    return Future.value();
  }
}

ColorScheme _getColorScheme({
  Color? color,
  required Brightness brightness,
}) {
  return ColorScheme.fromSeed(
    seedColor: color ?? $constants.theme.defaultThemeColor,
    brightness: brightness,
  );
}

AppColorScheme _getAppColorScheme({
  Color? color,
  required ColorScheme colorScheme,
  ColorScheme? dynamicColorScheme,
  required Brightness brightness,
}) {
  final isDark = brightness == Brightness.dark;

  return AppColorScheme.fromMaterialColorScheme(
    color != null
        ? colorScheme
        : $constants.theme.tryToGetColorPaletteFromWallpaper
            ? dynamicColorScheme ?? colorScheme
            : colorScheme,
    disabled: $constants.palette.grey,
    onDisabled: isDark ? $constants.palette.white : $constants.palette.black,
  );
}

AppTextTheme _getTextTheme({
  required AppTypography appTypography,
  required Brightness brightness,
}) {
  return brightness == Brightness.dark
      ? appTypography.white
      : appTypography.black;
}

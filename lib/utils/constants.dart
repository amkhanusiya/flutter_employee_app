import 'package:flutter/material.dart';

final $constants = Constants();

@immutable
class Constants {
  final appTitle = 'Employees';

  /// Theme defaults.
  late final theme = _Theme();

  /// Animation durations.
  late final times = _Times();

  /// Rounded edge corner radius.
  late final corners = _Corners();

  /// Padding and margin values.
  late final insets = _Insets();

  /// Text shadows.
  late final shadows = _Shadows();

  /// Color $constants.palette.
  late final palette = _Palette();

  late final employeeRole = _EmployeeRole();
}

@immutable
class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 32;
}

@immutable
class _Insets {
  late final double xxs = 4;
  late final double xs = 8;
  late final double sm = 16;
  late final double md = 24;
  late final double lg = 32;
  late final double xl = 48;
  late final double xxl = 56;
  late final double offset = 80;
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(
        color: Colors.black.withOpacity(0.25),
        offset: const Offset(0, 2),
        blurRadius: 4),
  ];
  final text = [
    Shadow(
        color: Colors.black.withOpacity(0.6),
        offset: const Offset(0, 2),
        blurRadius: 2),
  ];
  final textStrong = [
    Shadow(
        color: Colors.black.withOpacity(0.6),
        offset: const Offset(0, 4),
        blurRadius: 6),
  ];
}

@immutable
class _Palette {
  final List<Color> themes = [
    const Color(0xFFFF0000),
    const Color(0xFFFF8000),
    const Color(0xFFFCCC1A),
    const Color(0xFF66B032),
    const Color(0xFF00FFFF),
    const Color(0xFF0000FF),
    const Color(0xFF0080FF),
    const Color(0xFFFF00FF),
  ];

  final white = const Color(0xFFFFFFFF);
  final black = const Color(0xFF000000);
  final grey = const Color(0xFF9E9E9E);
  final red = const Color(0xFFFF0000);
  final orange = const Color(0xFFFF8000);
  final yellow = const Color(0xFFFCCC1A);
  final green = const Color(0xFF66B032);
  final cyan = const Color(0xFF00FFFF);
  final blue = const Color(0xFF0000FF);
  final purple = const Color(0xFF0080FF);
  final magenta = const Color(0xFFFF00FF);
  final borderColor = const Color(0xFFE5E5E5);
  final lightBlue = const Color(0xFFEDF8FF);
  final dividerColor = const Color(0xFFF2F2F2);
}

@immutable
class _Theme {
  final tryToGetColorPaletteFromWallpaper = true;
  final defaultThemeColor = const Color(0xFF1DA1F2);
  final defaultFontFamily = 'Roboto';
  final double defaultElevation = 4;
  final double defaultBorderRadius = 24;
  final double defaultBorderWidth = 1;
}

class _EmployeeRole {
  List<DropdownMenuEntry<String>> roles = const [
    DropdownMenuEntry<String>(
      label: "Product Designer",
      value: "product_designer",
    ),
    DropdownMenuEntry<String>(
      label: "Flutter Developer",
      value: "flutter_developer",
    ),
    DropdownMenuEntry<String>(
      label: "QA Tester",
      value: "qa_tester",
    ),
    DropdownMenuEntry<String>(
      label: "Product Owner",
      value: "product_owner",
    ),
  ];
}

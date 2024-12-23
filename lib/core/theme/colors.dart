import 'package:flutter/material.dart';

/// A private utility class that provides color constants used across
/// multiple palettes. These colors include shades and specific ARGB values
/// to maintain visual consistency.
class _FlaconiColors {
  static var blueDark = const Color(0xFF1E1926);
  static var blueDark1 = const Color(0xFF1E1926);
  static var grey50 = Colors.grey.shade50;
}

abstract class ColorPallete {
  /// Primary color used throughout the app.
  Color get primary;

  /// Color used for the app bar background.
  Color get appBar;

  /// Background color for the app.
  Color get background;
}

/// A color palette specifically designed for light theme modes.
///
/// [LightPallete] implements [ColorPallete] to provide a set of colors that
/// are optimized for light-themed user interfaces.
class LightPallete implements ColorPallete {
  @override
  Color get primary => _FlaconiColors.blueDark;

  @override
  Color get appBar => _FlaconiColors.blueDark;

  @override
  Color get background => _FlaconiColors.grey50;
}

/// A color palette specifically designed for dark theme modes.
///
/// [DarkPallete] implements [ColorPallete] to provide a set of colors optimized
/// for dark-themed user interfaces.
class DarkPallete implements ColorPallete {
  @override
  Color get primary => _FlaconiColors.blueDark;

  @override
  Color get appBar => _FlaconiColors.blueDark;

  @override
  Color get background => _FlaconiColors.blueDark1;
}

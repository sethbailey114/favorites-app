import 'package:flutter/material.dart';

/// Central place for the app's look. Change the colors here and every
/// screen updates, in both light and dark mode.
class AppTheme {
  AppTheme._();

  static const Color violet = Color(0xFF5B2EFF);
  static const Color coral = Color(0xFFFF3D71);
  static const Color teal = Color(0xFF00A38C);
  static const Color orange = Color(0xFFFF7A00);

  /// Accent colors that rotate across rows so lists feel lively.
  static const List<Color> accents = [violet, coral, teal, orange];

  static Color accentFor(int id) => accents[id % accents.length];

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final scheme =
        ColorScheme.fromSeed(
          seedColor: violet,
          brightness: brightness,
        ).copyWith(
          primary: isDark ? const Color(0xFF9B83FF) : violet,
          onPrimary: isDark ? Colors.black : Colors.white,
          secondary: isDark ? const Color(0xFFFF6B8E) : coral,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark
          ? const Color(0xFF0D0B1A)
          : const Color(0xFFF7F5FF),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: scheme.surface,
        selectedItemColor: scheme.primary,
        unselectedItemColor: scheme.outline,
        showUnselectedLabels: true,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (states) =>
                states.contains(WidgetState.selected) ? scheme.primary : null,
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>(
            (states) => states.contains(WidgetState.selected)
                ? scheme.onPrimary
                : scheme.onSurface,
          ),
        ),
      ),
    );
  }
}

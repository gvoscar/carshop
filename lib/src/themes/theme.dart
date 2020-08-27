import 'package:flutter/material.dart';

class AppThemeData {
  // Color de relleno claro.
  static const _lightFillColor = Colors.white;
  // Color de relleno oscuro.
  static const _darkFillColor = Colors.black;

  // Color de foco claro.
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  // Color de foco oscuro.
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  // Esquema de color claro.
  static const ColorScheme _lightColorScheme = ColorScheme(
      primary: Colors.indigo,
      primaryVariant: Color(0xFF303F9F),
      secondary: Colors.orange,
      secondaryVariant: Color(0xFFF57C00),
      surface: Color.fromARGB(0, 247, 247, 252),
      background: Color.fromARGB(0, 247, 247, 252),
      error: Color(0xFFB71C1C),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF241E30),
      onBackground: Colors.black,
      onError: Color.fromARGB(0, 247, 247, 252),
      brightness: Brightness.light);

  // Esquema de color oscuro.
  static const ColorScheme _darkColorScheme = ColorScheme(
      primary: Color(0xFF33333D),
      primaryVariant: Color(0xFF26282F),
      secondary: Colors.orange,
      secondaryVariant: Color(0xFFF57C00),
      surface: Color(0x03FEFEFE),
      background: Color(0xFF33333D),
      error: Color(0xFFD50000), //
      onPrimary: Color.fromARGB(0, 247, 247, 252),
      onSecondary: Color.fromARGB(0, 247, 247, 252),
      onSurface: Color.fromARGB(0, 247, 247, 252),
      onBackground: Color.fromARGB(0, 247, 247, 252),
      onError: Color.fromARGB(0, 247, 247, 252),
      brightness: Brightness.dark);

  /// Obtener tema claro de aplicación.
  static ThemeData getLight() {
    return ThemeData(
      colorScheme: _lightColorScheme,
      textTheme: ThemeData.light().textTheme,
      appBarTheme: AppBarTheme(
          textTheme: ThemeData.light()
              .textTheme
              .apply(bodyColor: _lightColorScheme.onPrimary),
          color: _lightColorScheme.background,
          elevation: 0.0,
          iconTheme: IconThemeData(color: _lightColorScheme.onPrimary),
          brightness: _lightColorScheme.brightness),
      iconTheme: IconThemeData(color: _lightColorScheme.onPrimary),
      canvasColor: _lightColorScheme.background,
      scaffoldBackgroundColor: _lightColorScheme.background,
      highlightColor: Colors.transparent,
      accentColor: _lightColorScheme.primary,
      focusColor: _lightFillColor,
      snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.alphaBlend(
            _lightFillColor.withOpacity(0.80),
            _darkFillColor,
          ),
          contentTextStyle: ThemeData.light()
              .textTheme
              .subtitle1
              .apply(color: _darkFillColor)),
    );
  }

  /// Obtener tema oscuro de aplicación.
  static ThemeData getDart() {
    return ThemeData(
      colorScheme: _darkColorScheme,
      textTheme: ThemeData.light().textTheme,
      appBarTheme: AppBarTheme(
          textTheme: ThemeData.light()
              .textTheme
              .apply(bodyColor: _darkColorScheme.onPrimary),
          color: _darkColorScheme.background,
          elevation: 0.0,
          iconTheme: IconThemeData(color: _darkColorScheme.onPrimary),
          brightness: _darkColorScheme.brightness),
      iconTheme: IconThemeData(color: _darkColorScheme.onPrimary),
      canvasColor: _darkColorScheme.background,
      scaffoldBackgroundColor: _darkColorScheme.background,
      highlightColor: Colors.transparent,
      accentColor: _darkColorScheme.primary,
      focusColor: _darkFillColor,
      snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.alphaBlend(
            _darkFillColor.withOpacity(0.80),
            _lightFillColor,
          ),
          contentTextStyle: ThemeData.light()
              .textTheme
              .subtitle1
              .apply(color: _lightFillColor)),
    );
  }

  // /// Tema claro.
  // static ThemeData light(BuildContext context) {
  //   return ThemeData(
  //     primaryColor: Colors.indigo,
  //     accentColor: Colors.indigo,
  //     backgroundColor: FlutColors.greyBlue,
  //     visualDensity: VisualDensity.adaptivePlatformDensity,
  //     //brightness: Brightness.light
  //   );
  // }

  // /// Tema claro.
  // static ThemeData dark(BuildContext context) {
  //   return ThemeData(
  //       primaryColor: Colors.white,
  //       accentColor: Colors.orange,
  //       visualDensity: VisualDensity.adaptivePlatformDensity,
  //       brightness: Brightness.dark);
  // }
}

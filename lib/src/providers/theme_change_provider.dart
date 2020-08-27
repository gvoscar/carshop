import 'package:flutter/material.dart';

class ThemeChangeProvider extends ChangeNotifier {
  ThemeData _themeData;

  ThemeChangeProvider(this._themeData);

  ThemeData getTheme() => this._themeData;
  setTheme(ThemeData theme) {
    this._themeData = theme;
    notifyListeners();
  }
}

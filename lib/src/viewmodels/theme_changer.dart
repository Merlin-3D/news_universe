import 'package:flutter/material.dart';
import 'package:news_universe/src/core/theming/theme.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  ThemeData get darkTheme {
    return darkThemeCustom();
  }

  ThemeData get lightTheme {
    return lightThemeCustom();
  }
}

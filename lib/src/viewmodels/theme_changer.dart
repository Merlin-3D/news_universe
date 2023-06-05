import 'package:flutter/material.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/shared/utils/common.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';

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

import 'package:flutter/material.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/shared/utils/common.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';

ThemeData darkThemeCustom() {
  return ThemeData.dark().copyWith(
      primaryColor: kNewsWhite,
      indicatorColor: kNewsWhite,
      colorScheme: const ColorScheme.dark(background: kNewsNeutral10),
      appBarTheme: const AppBarTheme(backgroundColor: kNewsNeutral10),
      textTheme: updateTextTheme(color: kNewsWhite),
      cardColor: kNewsNeutral20,
      hoverColor: kNewsError50,
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(backgroundColor: kNewsNeutral10),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: kNewsNeutral20),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: kNewsNeutral50,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
            borderRadius:
                BorderRadius.all(Radius.circular(Dimens.halfRadius.w)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
            borderRadius:
                BorderRadius.all(Radius.circular(Dimens.halfRadius.w)),
          )),
      tabBarTheme: const TabBarTheme(
          labelColor: kNewsError50, indicatorColor: kNewsError50));
}

ThemeData lightThemeCustom() {
  return ThemeData.light().copyWith(
      primaryColor: kNewsPrimary60,
      colorScheme: const ColorScheme.dark(background: kNewsWhite),
      appBarTheme: const AppBarTheme(backgroundColor: kNewsPrimary30),
      textTheme: updateTextTheme(color: kNewsNeutral20),
      indicatorColor: kNewsNeutral20,
      hoverColor: kNewsPrimary60,
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: kNewsPrimary20),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: kNewsPrimary50,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
            borderRadius:
                BorderRadius.all(Radius.circular(Dimens.halfRadius.w)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
            borderRadius:
                BorderRadius.all(Radius.circular(Dimens.halfRadius.w)),
          )),
      tabBarTheme: const TabBarTheme(
          labelColor: kNewsWhite, indicatorColor: kNewsError50));
}

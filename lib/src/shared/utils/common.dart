import 'package:flutter/material.dart';
import 'package:news_universe/generated/assets.gen.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';

TextTheme updateTextTheme({Color? color}) {
  return TextTheme(
          headlineLarge: TextStyle(
              fontSize: 22.h, fontWeight: FontWeight.w800, color: color),
          headlineMedium: TextStyle(
              fontSize: 18.h, fontWeight: FontWeight.w700, color: color),
          headlineSmall: TextStyle(
              fontSize: 16.h, fontWeight: FontWeight.w600, color: color),
          displayLarge: TextStyle(
              fontSize: 14.h, fontWeight: FontWeight.w500, color: color),
          displayMedium: TextStyle(
              fontSize: 12.h, fontWeight: FontWeight.w300, color: color),
          displaySmall: TextStyle(
              fontSize: 10.h, fontWeight: FontWeight.w200, color: color))
      .apply(
    fontFamily: 'OpenSans',
  );
}

ThemeData getCommonThen() {
  return ThemeData.light().copyWith(
      primaryColor: kNewsPrimary60,
      colorScheme: const ColorScheme.dark(background: kNewsWhite),
      appBarTheme: const AppBarTheme(backgroundColor: kNewsPrimary30),
      textTheme: updateTextTheme(color: kNewsNeutral20),
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

List<BottomNavigationBarItem> bottomNavigationBarItem(BuildContext context) {
  return [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        Assets.icons.home2,
      ),
      activeIcon: SvgPicture.asset(
        Assets.icons.home2,
        colorFilter:
            ColorFilter.mode(Theme.of(context).hoverColor, BlendMode.srcIn),
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        Assets.icons.heart,
      ),
      activeIcon: SvgPicture.asset(
        Assets.icons.heart,
        colorFilter:
            ColorFilter.mode(Theme.of(context).hoverColor, BlendMode.srcIn),
      ),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(Assets.icons.setting2),
      activeIcon: SvgPicture.asset(
        Assets.icons.setting2,
        colorFilter:
            ColorFilter.mode(Theme.of(context).hoverColor, BlendMode.srcIn),
      ),
      label: 'Settings',
    ),
  ];
}

List<Widget> tabsList = const [
  Tab(
    text: 'General',
  ),
  Tab(text: 'Business'),
  Tab(text: 'Science'),
  Tab(
    text: 'Sports',
  ),
];

List<String> sortByItems = [
  'relevancy',
  'popularity',
  'publishedAt',
];

List<String> typeArticlesItems = [
  'general',
  'business',
  'science',
  'sports',
];

List<String> uploadDateItems = [
  'today',
  'this week',
  'this month',
  'this year',
];

String capitalizeFirstWord(String text) {
  if (text.isEmpty) {
    return text;
  }

  return text[0].toUpperCase() + text.substring(1);
}

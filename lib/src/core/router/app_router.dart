import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_universe/src/core/router/wrappers/bottom_navigation_wrapper.dart';
import 'package:news_universe/src/core/router/wrappers/main_wrapper.dart';
import 'package:news_universe/src/features/article_detail/article_detail_screen.dart';
import 'package:news_universe/src/features/favorites/favorites_screen.dart';
import 'package:news_universe/src/features/home/home.screen.dart';
import 'package:news_universe/src/features/search/search_screen.dart';
import 'package:news_universe/src/features/settings/setting_screen.dart';
import 'package:news_universe/src/models/article_model.dart';
part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '', page: MainWrapper, name: 'MainRoute', children: [
      AutoRoute(
          path: '',
          page: BottomNavigationWrapper,
          name: 'BottomNavigationRoute',
          children: [
            AutoRoute(
              page: HomeScreen,
              initial: true,
            ),
            AutoRoute(page: FavoritesScreen),
            AutoRoute(page: SettingScreen),
          ]),
      AutoRoute(page: ArticleDetailScreen),
      AutoRoute(page: SearchScreen)
    ]),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter();
}

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MainWrapper(),
      );
    },
    BottomNavigationRoute.name: (routeData) {
      final args = routeData.argsAs<BottomNavigationRouteArgs>(
          orElse: () => const BottomNavigationRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: BottomNavigationWrapper(key: args.key),
      );
    },
    ArticleDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ArticleDetailRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ArticleDetailScreen(
          key: args.key,
          article: args.article,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    FavoritesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const FavoritesScreen(),
      );
    },
    SettingRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SettingScreen(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          MainRoute.name,
          path: '',
          children: [
            RouteConfig(
              BottomNavigationRoute.name,
              path: '',
              parent: MainRoute.name,
              children: [
                RouteConfig(
                  HomeRoute.name,
                  path: '',
                  parent: BottomNavigationRoute.name,
                ),
                RouteConfig(
                  FavoritesRoute.name,
                  path: 'favorites-screen',
                  parent: BottomNavigationRoute.name,
                ),
                RouteConfig(
                  SettingRoute.name,
                  path: 'setting-screen',
                  parent: BottomNavigationRoute.name,
                ),
              ],
            ),
            RouteConfig(
              ArticleDetailRoute.name,
              path: 'article-detail-screen',
              parent: MainRoute.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [MainWrapper]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [BottomNavigationWrapper]
class BottomNavigationRoute extends PageRouteInfo<BottomNavigationRouteArgs> {
  BottomNavigationRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          BottomNavigationRoute.name,
          path: '',
          args: BottomNavigationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'BottomNavigationRoute';
}

class BottomNavigationRouteArgs {
  const BottomNavigationRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'BottomNavigationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ArticleDetailScreen]
class ArticleDetailRoute extends PageRouteInfo<ArticleDetailRouteArgs> {
  ArticleDetailRoute({
    Key? key,
    required ArticleModel article,
  }) : super(
          ArticleDetailRoute.name,
          path: 'article-detail-screen',
          args: ArticleDetailRouteArgs(
            key: key,
            article: article,
          ),
        );

  static const String name = 'ArticleDetailRoute';
}

class ArticleDetailRouteArgs {
  const ArticleDetailRouteArgs({
    this.key,
    required this.article,
  });

  final Key? key;

  final ArticleModel article;

  @override
  String toString() {
    return 'ArticleDetailRouteArgs{key: $key, article: $article}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [FavoritesScreen]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute()
      : super(
          FavoritesRoute.name,
          path: 'favorites-screen',
        );

  static const String name = 'FavoritesRoute';
}

/// generated route for
/// [SettingScreen]
class SettingRoute extends PageRouteInfo<void> {
  const SettingRoute()
      : super(
          SettingRoute.name,
          path: 'setting-screen',
        );

  static const String name = 'SettingRoute';
}

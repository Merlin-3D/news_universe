import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_universe/src/core/router/app_router.dart';
import 'package:news_universe/src/shared/utils/common.dart';
import 'package:news_universe/src/viewmodels/articles_viewmodels.dart';
import 'package:news_universe/src/viewmodels/theme_changer.dart';
import 'package:provider/provider.dart';

class NewsUniverse extends StatelessWidget {
  NewsUniverse({super.key});
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeChanger>(
          create: (_) => ThemeChanger(getCommonThen()),
        ),
        ChangeNotifierProvider(
          create: (_) => ArticleViewModel(),
        )
      ],
      child: Consumer<ThemeChanger>(builder: (context, themeChanger, _) {
        final currentTheme = themeChanger.getTheme();
        return MaterialApp.router(
          title: 'News Universe',
          debugShowCheckedModeBanner: false,
          theme: currentTheme,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
        );
      }),
    );
  }
}

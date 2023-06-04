import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news_universe/src/core/router/app_router.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/features/article_detail/article_detail_screen.dart';
import 'package:news_universe/src/shared/components/article_card.dart';
import 'package:news_universe/src/shared/components/empty_message.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';
import 'package:news_universe/src/viewmodels/articles_viewmodels.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ArticleViewModel>(context, listen: false).getAllFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(builder: (context, articleViewModel, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
            elevation: 0,
            title: Text(
              'Favorites',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: kNewsWhite),
            )),
        body: articleViewModel.articlesInFavorites.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.padding.w),
                child: ListView.builder(
                  reverse: true,
                  itemCount: articleViewModel.articlesInFavorites.length,
                  itemBuilder: (context, index) {
                    return ArticleCard(
                        isLiked: true,
                        onPressed: () {
                          articleViewModel.setIndexLiked(value: index);
                          context.router.navigate(ArticleDetailRoute(
                              mode: ModeDisplay.other,
                              article:
                                  articleViewModel.articlesInFavorites[index]));
                        },
                        article: articleViewModel.articlesInFavorites[index]);
                  },
                ),
              )
            : EmptyMessage(
                type: EmptyType.empty, message: "No favorite items..."),
      );
    });
  }
}

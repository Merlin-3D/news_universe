import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news_universe/src/core/router/app_router.dart';

import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/features/article_detail/article_detail_screen.dart';
import 'package:news_universe/src/models/article_model.dart';
import 'package:news_universe/src/shared/components/article_card.dart';
import 'package:news_universe/src/shared/components/empty_message.dart';
import 'package:news_universe/src/shared/components/loader.dart';
import 'package:news_universe/src/viewmodels/articles_viewmodels.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';

class NewsViewList extends StatelessWidget {
  const NewsViewList(
      {Key? key,
      required this.isLoading,
      required this.errorMessage,
      required this.articles,
      required this.articleViewModel,
      required this.controller,
      this.horizontal = Dimens.padding,
      this.fetchData,
      this.emptyType = EmptyType.error})
      : super(key: key);

  final bool isLoading;
  final String errorMessage;
  final List<ArticleModel> articles;
  final ArticleViewModel articleViewModel;
  final double horizontal;
  final Future<void>? fetchData;
  final ScrollController controller;
  final EmptyType? emptyType;

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Loader()
        : articles.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontal.w),
                child: ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    if (index == articles.length) {
                      return const Loader();
                    }
                    return ArticleCard(
                        onPressed: () {
                          articleViewModel.setIndexLiked(value: index);
                          context.router.navigate(ArticleDetailRoute(
                              mode: ModeDisplay.home,
                              article: articles[index]));
                        },
                        article: articles[index]);
                  },
                  // controller: controller
                  //   ..addListener(() {
                  //     if (controller.position.pixels ==
                  //         controller.position.maxScrollExtent) {
                  //       fetchData;
                  //     }
                  //   }),
                ),
              )
            : EmptyMessage(type: emptyType!, message: errorMessage);
  }
}

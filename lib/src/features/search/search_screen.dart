import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/shared/components/empty_message.dart';
import 'package:news_universe/src/shared/components/input.dart';
import 'package:news_universe/src/shared/components/news_view_list.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';
import 'package:news_universe/generated/assets.gen.dart';
import 'package:news_universe/src/viewmodels/articles_viewmodels.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(builder: (context, articleViewModel, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          color: Theme.of(context).colorScheme.background,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.padding.w),
            child: Column(
              children: [
                SizedBox(
                  height: Dimens.appBarHeight.h - Dimens.doubleSpace.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        width: 32.w,
                        Assets.icons.arrowLeft,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).primaryColor, BlendMode.srcIn),
                      ),
                    ),
                    SizedBox(
                      width: Dimens.minSpace.w,
                    ),
                    Expanded(
                        child: Input(
                      hintText: 'Search',
                      onChanged: (value) =>
                          articleViewModel.setSearchInput(value: value),
                      suffix: InkWell(
                        onTap: () {
                          articleViewModel.setLoadingSearch(value: true);
                          articleViewModel.searchArticles();
                        },
                        child: SvgPicture.asset(
                          width: 16,
                          Assets.icons.searchStatus,
                          colorFilter: const ColorFilter.mode(
                              kNewsWhite, BlendMode.srcIn),
                        ),
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: Dimens.halfSpace.h,
                ),
                const Divider(),
                Expanded(
                    child: NewsViewList(
                  emptyType: articleViewModel.articlesSearch.isEmpty
                      ? EmptyType.empty
                      : EmptyType.error,
                  horizontal: 0,
                  controller: _scrollController,
                  articleViewModel: articleViewModel,
                  errorMessage: articleViewModel.articlesSearch.isEmpty
                      ? "No item Found"
                      : articleViewModel.searchErrorMessage,
                  isLoading: articleViewModel.isLoadingSearch,
                  articles: articleViewModel.articlesSearch,
                  // fetchData: articleViewModel
                  //     .fetchArticlesSport()
                ))
              ],
            ),
          ),
        ),
      );
    });
  }
}

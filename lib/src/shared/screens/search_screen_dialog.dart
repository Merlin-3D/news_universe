import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/shared/components/input.dart';
import 'package:news_universe/src/shared/components/loader.dart';
import 'package:news_universe/src/shared/components/news_view_list.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';
import 'package:news_universe/generated/assets.gen.dart';
import 'package:news_universe/src/viewmodels/articles_viewmodels.dart';

class SearchScreenDialog extends StatelessWidget {
  SearchScreenDialog({super.key, required this.articleViewModel});

  final ArticleViewModel articleViewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: StatefulBuilder(builder: (context, StateSetter setState) {
        return Container(
          color: Theme.of(context).colorScheme.background,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.padding.w),
            child: Column(
              children: [
                SizedBox(
                  height: Dimens.space.h,
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
                      onChanged: (value) {
                        setState(() {
                          articleViewModel.setSearchInput(value: value);
                        });
                      },
                      suffix: InkWell(
                        onTap: () => articleViewModel.searchArticles(),
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
                    child: articleViewModel.isLoadingSearch == true
                        ? const Loader()
                        : articleViewModel.articlesSearch.isNotEmpty
                            ? NewsViewList(
                                horizontal: 0,
                                controller: _scrollController,
                                articleViewModel: articleViewModel,
                                errorMessage:
                                    articleViewModel.searchErrorMessage,
                                isLoading: articleViewModel.isLoadingSearch,
                                articles: articleViewModel.articlesSearch,
                                // fetchData: articleViewModel
                                //     .fetchArticlesSport()
                              )
                            : const Text('error'))
              ],
            ),
          ),
        );
      }),
    );
  }
}

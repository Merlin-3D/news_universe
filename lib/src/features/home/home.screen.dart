import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_universe/generated/assets.gen.dart';
import 'package:news_universe/src/core/router/app_router.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/shared/components/news_view_list.dart';
import 'package:news_universe/src/shared/screens/filter_dialog.dart';
import 'package:news_universe/src/shared/utils/common.dart';
import 'package:news_universe/src/viewmodels/articles_viewmodels.dart';
import 'package:news_universe/src/viewmodels/theme_changer.dart';
import 'package:provider/provider.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  // final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(builder: (context, themeChanger, _) {
      return Consumer<ArticleViewModel>(
          builder: (context, articleViewModel, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: 80,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(Dimens.padding.w),
                  title: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () {
                            articleViewModel.setSearchInput(value: '');
                            context.router.navigate(const SearchRoute());
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimens.halfRadius.w),
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor),
                            child: SizedBox(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.h, horizontal: Dimens.space.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Search',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(color: kNewsWhite),
                                    ),
                                    SvgPicture.asset(
                                      width: 12,
                                      Assets.icons.searchStatus,
                                      colorFilter: const ColorFilter.mode(
                                          kNewsWhite, BlendMode.srcIn),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimens.minSpace.w,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FilterDialog(
                                        index: tabIndex,
                                        articleViewModel: articleViewModel);
                                  },
                                );
                              },
                              child: SvgPicture.asset(
                                width: 16,
                                Assets.icons.filter,
                                colorFilter: const ColorFilter.mode(
                                    kNewsWhite, BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Theme.of(context).tabBarTheme.labelColor,
                    indicator: Theme.of(context).tabBarTheme.indicator,
                    onTap: (value) {
                      setState(() {
                        tabIndex = value;
                      });
                    },
                    indicatorColor:
                        Theme.of(context).tabBarTheme.indicatorColor,
                    tabs: tabsList,
                    controller: _tabController, // Assigner le TabController
                  ),
                ),
                pinned: true,
              ),
            ],
            body: TabBarView(
              controller: _tabController, // Assigner le TabController
              children: [
                NewsViewList(
                  articleViewModel: articleViewModel,
                  errorMessage: articleViewModel.errorMessage,
                  isLoading: articleViewModel.isLoadingArticle,
                  articles: articleViewModel.articles,
                  controller: _scrollController,
                  horizontal: 0,
                  // fetchData: articleViewModel.fetchArticles()
                ),
                NewsViewList(
                  articleViewModel: articleViewModel,
                  errorMessage: articleViewModel.errorMessageBusiness,
                  isLoading: articleViewModel.isLoadingBussiness,
                  articles: articleViewModel.business,
                  controller: _scrollController,
                  horizontal: 0,
                  // fetchData: articleViewModel.fetchArticlesBusiness()
                ),
                NewsViewList(
                  articleViewModel: articleViewModel,
                  errorMessage: articleViewModel.errorMessageSciences,
                  isLoading: articleViewModel.isLoadingScience,
                  articles: articleViewModel.sciences,
                  controller: _scrollController,
                  horizontal: 0,
                  // fetchData: articleViewModel.fetchArticlesSciences()
                ),
                NewsViewList(
                  articleViewModel: articleViewModel,
                  errorMessage: articleViewModel.errorMessageSport,
                  isLoading: articleViewModel.isLoadingSport,
                  articles: articleViewModel.sports,
                  controller: _scrollController,
                  horizontal: 0,
                  // fetchData: articleViewModel.fetchArticlesSport()
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Theme.of(context).appBarTheme.backgroundColor, child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

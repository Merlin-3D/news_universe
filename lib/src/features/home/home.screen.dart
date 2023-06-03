import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:news_universe/src/core/router/app_router.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/models/article_model.dart';
import 'package:news_universe/src/shared/components/article_card.dart';
import 'package:news_universe/src/shared/components/empty_message.dart';
import 'package:news_universe/src/shared/components/input.dart';
import 'package:news_universe/src/shared/components/loader.dart';
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
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    Provider.of<ArticleViewModel>(context, listen: false).fetchArticles();
    Provider.of<ArticleViewModel>(context, listen: false).fetchArticlesSport();
    Provider.of<ArticleViewModel>(context, listen: false)
        .fetchArticlesBusiness();
    Provider.of<ArticleViewModel>(context, listen: false)
        .fetchArticlesSciences();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                expandedHeight: 90,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(Dimens.padding.w),
                  title: const Input(
                    hintText: 'Search',
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Theme.of(context).tabBarTheme.labelColor,
                    indicator: Theme.of(context).tabBarTheme.indicator,
                    indicatorColor:
                        Theme.of(context).tabBarTheme.indicatorColor,
                    tabs: const [
                      Tab(
                        text: 'General',
                      ),
                      Tab(text: 'Business'),
                      Tab(text: 'Science'),
                      Tab(
                        text: 'Sports',
                      ),
                    ],
                    controller: _tabController, // Assigner le TabController
                  ),
                ),
                pinned: true,
              ),
            ],
            body: TabBarView(
              controller: _tabController, // Assigner le TabController
              children: [
                newsViewList(
                    errorMessage: articleViewModel.errorMessage,
                    isLoading: articleViewModel.isLoadingArticle,
                    articles: articleViewModel.articles,
                    fetchData: articleViewModel.fetchArticles()),
                // Contenu de l'onglet 2
                newsViewList(
                    errorMessage: articleViewModel.errorMessageBusiness,
                    isLoading: articleViewModel.isLoadingArticle,
                    articles: articleViewModel.business,
                    fetchData: articleViewModel.fetchArticlesBusiness()),
                // Contenu de l'onglet 3
                newsViewList(
                    errorMessage: articleViewModel.errorMessageSciences,
                    isLoading: articleViewModel.isLoadingArticle,
                    articles: articleViewModel.sciences,
                    fetchData: articleViewModel.fetchArticlesSciences()),
                newsViewList(
                    errorMessage: articleViewModel.errorMessageSport,
                    isLoading: articleViewModel.isLoadingArticle,
                    articles: articleViewModel.sports,
                    fetchData: articleViewModel.fetchArticlesSport()),
              ],
            ),
          ),
        );
      });
    });
  }

  Widget newsViewList(
      {required bool isLoading,
      required String errorMessage,
      required List<ArticleModel> articles,
      required Future<void> fetchData}) {
    return isLoading == true
        ? const Loader()
        : articles.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.padding.w),
                child: ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    if (index == articles.length) {
                      return const Loader();
                    }
                    return ArticleCard(
                        onPressed: () => context.router.navigate(
                            ArticleDetailRoute(article: articles[index])),
                        article: articles[index]);
                  },
                  controller: _scrollController
                    ..addListener(() {
                      if (_scrollController.position.pixels ==
                          _scrollController.position.maxScrollExtent) {
                        fetchData;
                      }
                    }),
                ),
              )
            : EmptyMessage(type: EmptyType.error, message: errorMessage);
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_universe/generated/assets.gen.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/models/article_model.dart';
import 'package:news_universe/src/shared/components/button.dart';
import 'package:news_universe/src/shared/components/snack_bar_message.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';
import 'package:news_universe/src/viewmodels/articles_viewmodels.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum ModeDisplay { home, other }

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen(
      {super.key, required this.article, required this.mode});

  final ArticleModel article;
  final ModeDisplay mode;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.mode == ModeDisplay.other) {
      Provider.of<ArticleViewModel>(context, listen: false).getFavorite(
          index:
              Provider.of<ArticleViewModel>(context, listen: false).indexLiked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(builder: (context, articleViewModel, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.article.author!,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: kNewsWhite),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: Dimens.padding),
              child: Row(
                children: [
                  RawMaterialButton(
                    constraints: const BoxConstraints(),
                    onPressed: () => widget.article !=
                            articleViewModel.articleLiked
                        ? addFavorite(articleViewModel: articleViewModel)
                        : removeFavorite(articleViewModel: articleViewModel),
                    child: Icon(
                      Icons.favorite,
                      size: 26,
                      color: widget.article == articleViewModel.articleLiked
                          ? kNewsError50
                          : kNewsWhite,
                    ),
                  ),
                  RawMaterialButton(
                    constraints: const BoxConstraints(),
                    onPressed: () => Share.share(
                        'Follow all the news on news universe: ${widget.article.url}',
                        sharePositionOrigin: Rect.zero),
                    child: SvgPicture.asset(
                      Assets.icons.share,
                      colorFilter:
                          const ColorFilter.mode(kNewsWhite, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.padding.w),
          child: ListView(
            children: [
              SizedBox(
                height: Dimens.space.h,
              ),
              Text(
                widget.article.title!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(
                height: Dimens.minSpace.h,
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    '${widget.article.source!['name']} / ',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: kNewsPrimary30),
                  ),
                  Text(
                    timeago.format(DateTime.parse(widget.article.publishedAt!),
                        locale: 'en_short'),
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const Divider(),
              widget.article.urlToImage!.isNotEmpty
                  ? ClipRRect(
                      child: CachedNetworkImage(
                      imageUrl: widget.article.urlToImage!,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ))
                  : const SizedBox(),
              SizedBox(
                height: Dimens.doubleSpace.h,
              ),
              Text(
                widget.article.description!,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              const Divider(),
              SizedBox(
                height: Dimens.space.h,
              ),
              Text(
                widget.article.content!,
                maxLines: 4,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: Dimens.tripleSpace.h,
              ),
              Button(onPressed: _launchUrl, text: "Read More")
            ],
          ),
        ),
      );
    });
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(widget.article.url!);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void addFavorite({required ArticleViewModel articleViewModel}) {
    articleViewModel.addInFavorite(articleModel: widget.article);
    displayMessage(message: "Add has been success...");
  }

  void removeFavorite({required ArticleViewModel articleViewModel}) {
    articleViewModel.deleteArticle();
    displayMessage(message: "The article has been deleted...");
  }

  void displayMessage({required String message}) {
    final snackBar = SnackBarMessage.create(
        message: message,
        type: SnackbarColor.primary,
        context: context,
        onUndo: () {});
    SnackBarMessage.showSnackbar(snackBar: snackBar, context: context);
  }
}

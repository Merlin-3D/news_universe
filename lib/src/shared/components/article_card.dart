import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_universe/generated/assets.gen.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/models/article_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_universe/src/shared/utils/sized_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard(
      {super.key,
      required this.article,
      required this.onPressed,
      this.isLiked = false});

  final ArticleModel article;
  final bool? isLiked;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Card(
        elevation: 1,
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.halfRadius.w)),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    article.urlToImage!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Dimens.halfRadius.w),
                                topRight: Radius.circular(Dimens.halfRadius.w)),
                            child: CachedNetworkImage(
                              height: 200.h,
                              width: MediaQuery.of(context).size.width,
                              imageUrl: article.urlToImage!,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: Dimens.space.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimens.halfPadding.w),
                      child: Column(
                        children: [
                          Text(
                            article.title!,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(
                            height: Dimens.halfSpace.w,
                          ),
                          Text(
                            article.description!,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            height: Dimens.space.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(Assets.icons.wifiSquare,
                                      colorFilter: const ColorFilter.mode(
                                          kNewsError50, BlendMode.srcIn)),
                                  SizedBox(
                                    width: Dimens.minSpace.w,
                                  ),
                                  Text(
                                    article.source!['name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  isLiked == true
                                      ? const Icon(
                                          Icons.favorite,
                                          size: 14,
                                          color: kNewsError50,
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    width: Dimens.minSpace.w,
                                  ),
                                  Text(
                                    timeago.format(
                                        DateTime.parse(article.publishedAt!),
                                        locale: 'en_short'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: Dimens.space.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';

class Category extends StatelessWidget {
  const Category({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.extraLargeRadius),
            color: Theme.of(context).hoverColor),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.padding.w, vertical: Dimens.halfPadding.h),
          child: Text(content,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: kNewsWhite,
                  )),
        ));
  }
}

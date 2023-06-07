import 'package:flutter/material.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/shared/screens/components/filter_choose.dart';
import 'package:news_universe/src/shared/utils/common.dart';
import 'package:news_universe/src/shared/utils/date_range.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';
import 'package:news_universe/src/viewmodels/articles_viewmodels.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog(
      {super.key, required this.articleViewModel, required this.index});

  final ArticleViewModel articleViewModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: StatefulBuilder(builder: (context, StateSetter setState) {
        return Container(
          height: 300.h,
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.padding.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimens.space.h,
                    ),
                    Text(
                      'Search filter',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: Dimens.tripleSpace.h,
                    ),
                    FilterChoose(
                        items: sortByItems,
                        hintText: "Relevancy",
                        label: "Sort By",
                        value: articleViewModel.sortByValue,
                        onChanged: (p0) {
                          setState(() => articleViewModel.setSortByValue(
                              value: p0 as String));
                        }),
                    SizedBox(
                      height: Dimens.space.h,
                    ),
                    FilterChoose(
                      items: typeArticlesItems,
                      hintText: "Genral",
                      label: "Type",
                      value: articleViewModel.typeValue,
                      onChanged: (p0) {
                        setState(() =>
                            articleViewModel.setTypeValue(value: p0 as String));
                      },
                    ),
                    SizedBox(
                      height: Dimens.space.h,
                    ),
                    FilterChoose(
                        items: uploadDateItems,
                        hintText: "Anytime",
                        label: "Upload Date",
                        value: articleViewModel.uploadDate,
                        onChanged: (p0) {
                          setState(() => articleViewModel.setUploadDate(
                              value: p0 as String));
                        }),
                    SizedBox(
                      height: Dimens.doubleSpace.h,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Divider(),
                    SizedBox(
                      height: Dimens.space.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: Theme.of(context).hoverColor,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          width: Dimens.tripleSpace.w,
                        ),
                        InkWell(
                          onTap: () {
                            switch (index) {
                              case 0:
                                articleViewModel.setIsLoadingValue(value: true);
                                articleViewModel.fetchArticles(
                                    sortBy: articleViewModel.sortByValue,
                                    fromDate: DateRange.formattedDateFilter(
                                        type: articleViewModel.uploadDate)[0],
                                    toDate: DateRange.formattedDateFilter(
                                        type: articleViewModel.uploadDate)[1]);
                                break;
                              case 1:
                                articleViewModel.setIsLoadingBussinessValue(
                                    value: true);
                                articleViewModel.fetchArticlesBusiness(
                                    sortBy: articleViewModel.sortByValue,
                                    fromDate: DateRange.formattedDateFilter(
                                        type: articleViewModel.uploadDate)[0],
                                    toDate: DateRange.formattedDateFilter(
                                        type: articleViewModel.uploadDate)[1]);
                                break;
                              case 2:
                                articleViewModel.setIsLoadingScienceValue(
                                    value: true);
                                articleViewModel.fetchArticlesSciences(
                                    sortBy: articleViewModel.sortByValue,
                                    fromDate: DateRange.formattedDateFilter(
                                        type: articleViewModel.uploadDate)[0],
                                    toDate: DateRange.formattedDateFilter(
                                        type: articleViewModel.uploadDate)[1]);
                                break;
                              case 3:
                                articleViewModel.setIsLoadingSportValue(
                                    value: true);
                                articleViewModel.fetchArticlesSport(
                                    sortBy: articleViewModel.sortByValue,
                                    fromDate: DateRange.formattedDateFilter(
                                        type: articleViewModel.uploadDate)[0],
                                    toDate: DateRange.formattedDateFilter(
                                        type: articleViewModel.uploadDate)[1]);
                                break;
                            }
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Apply",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: Theme.of(context).hoverColor,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimens.doubleSpace.h,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

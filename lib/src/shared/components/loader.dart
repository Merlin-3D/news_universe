import 'package:flutter/material.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: Dimens.doubleSpace.w,
            height: Dimens.doubleSpace.w,
            child: const CircularProgressIndicator())
      ],
    );
  }
}

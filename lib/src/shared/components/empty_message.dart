import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_universe/generated/assets.gen.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';

enum EmptyType { empty, error }

class EmptyMessage extends StatelessWidget {
  EmptyMessage({super.key, required this.type, required this.message});

  final EmptyType type;
  final String message;

  final Map<EmptyType, String> imagesPath = {
    EmptyType.empty: Assets.icons.infocircle,
    EmptyType.error: Assets.icons.closeCircle,
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 100.h,
              width: 100.w,
              child: SvgPicture.asset(
                imagesPath[type]!,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).hoverColor, BlendMode.srcIn),
              )),
          SizedBox(
            height: Dimens.doubleSpace.h,
          ),
          Text(message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

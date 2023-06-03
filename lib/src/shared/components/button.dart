import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.right,
    this.simple = false,
    this.iconPath,
  });
  final VoidCallback onPressed;
  final String text;
  final Widget? right;
  final bool simple;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kNewsPrimary60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.halfRadius.w),
        ),
        elevation: 1.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.padding),
        child: Row(
          children: [
            if (iconPath != null)
              Expanded(flex: 1, child: SvgPicture.asset(iconPath!))
            else
              const Expanded(flex: 0, child: SizedBox()),
            Expanded(
              flex: 4,
              child: Text(
                text,
                textAlign:
                    iconPath != null ? TextAlign.start : TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: kNewsWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

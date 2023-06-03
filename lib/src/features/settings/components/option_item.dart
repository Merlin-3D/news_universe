import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_universe/generated/assets.gen.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';

class OtionItem extends StatelessWidget {
  const OtionItem(
      {super.key,
      required this.title,
      this.description,
      this.onPressed,
      this.switchValue = false,
      this.isSimple = false,
      this.onSwitchChanged,
      this.displaySwitch = false});

  final String title;
  final String? description;
  final bool? displaySwitch;
  final bool? switchValue;
  final bool? isSimple;
  final Function(bool)? onSwitchChanged;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: Dimens.minSpace.h,
                ),
                if (description != null)
                  Text(
                    description!,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  )
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  displaySwitch != true
                      ? isSimple == false
                          ? SvgPicture.asset(
                              Assets.icons.arrowRight,
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context).indicatorColor,
                                  BlendMode.srcIn),
                            )
                          : const SizedBox()
                      : Switch(
                          activeColor: Theme.of(context).hoverColor,
                          inactiveTrackColor: kNewsNeutral80,
                          value: switchValue!,
                          onChanged: onSwitchChanged,
                        )
                ],
              ))
        ],
      ),
    );
  }
}

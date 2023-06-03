import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:flutter/material.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';

class Input extends StatelessWidget {
  const Input(
      {super.key,
      this.hintText,
      this.suffix,
      this.obscureText = false,
      this.onChanged,
      this.validator,
      this.controller,
      this.keyboardType,
      this.enabled,
      this.focusNode});

  final String? hintText;
  final bool obscureText;
  final bool? readOnly = false;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onChanged: onChanged,
      enabled: enabled,
      style: Theme.of(context).textTheme.displayMedium,
      cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            EdgeInsets.symmetric(horizontal: Dimens.padding.w, vertical: 4),
        filled: true,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: kNewsWhite),
        suffix: suffix,
      ),
    );
  }
}

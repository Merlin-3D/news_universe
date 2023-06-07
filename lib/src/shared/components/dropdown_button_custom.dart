import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:news_universe/src/shared/utils/common.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';

class DropdownButtonCustom extends StatelessWidget {
  const DropdownButtonCustom(
      {super.key,
      required this.items,
      this.value,
      this.onChanged,
      required this.hintText});

  final List<String> items;
  final Object? value;
  final void Function(Object?)? onChanged;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        iconStyleData:
            IconStyleData(iconEnabledColor: Theme.of(context).hoverColor),
        hint: Text(
          capitalizeFirstWord(hintText),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    capitalizeFirstWord(item),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ))
            .toList(),
        value: value,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          height: 40.h,
          width: 140.w,
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 40.h,
        ),
      ),
    );
  }
}

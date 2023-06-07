import 'package:flutter/material.dart';

import 'package:news_universe/src/shared/components/dropdown_button_custom.dart';

class FilterChoose extends StatelessWidget {
  const FilterChoose({
    Key? key,
    required this.items,
    this.value,
    required this.hintText,
    required this.label,
    this.onChanged,
  }) : super(key: key);

  final List<String> items;
  final Object? value;
  final void Function(Object?)? onChanged;
  final String hintText;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        DropdownButtonCustom(
          items: items,
          value: value,
          hintText: hintText,
          onChanged: onChanged,
        )
      ],
    );
  }
}

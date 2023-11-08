import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

class AppDropDown<T> extends StatelessWidget {
  final List<DropdownMenuEntry<T>> entries;
  final String hint;
  final String svgName;
  final T? selected;
  final String? Function(T?)? validator;
  final Function(T?)? onChanged;

  const AppDropDown({
    required this.entries,
    this.hint = '',
    this.svgName = '',
    this.selected,
    this.validator,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      items: entries
          .map(
            (e) => DropdownMenuItem(
              value: e.value,
              child: Text(e.label),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,
      value: selected,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: svgName.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SvgPicture.asset(svgName),
              )
            : const SizedBox.shrink(),
        prefixIconConstraints: svgName.isNotEmpty
            ? BoxConstraints(
                minHeight: Adaptive.dp(24),
                minWidth: Adaptive.dp(24),
              )
            : BoxConstraints(
                minHeight: Adaptive.dp(10),
                minWidth: Adaptive.dp(10),
              ),
      ),
    );
  }
}

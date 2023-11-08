import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String svgName;
  final bool readOnly;
  final String? Function(String?)? validator;
  final Function()? onTap;

  const AppTextField({
    required this.controller,
    this.hint = '',
    this.svgName = '',
    this.readOnly = false,
    this.validator,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      validator: validator,
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

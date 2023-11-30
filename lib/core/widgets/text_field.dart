import 'package:employee_management/core/theme/app_style.dart';
import 'package:employee_management/core/widgets/custom_icon_widget.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool enable;
  final bool readOnly;
  final String assetPath;
  final String suffixPath;
  final String hintText;
  final bool large;
  const CustomTextFieldWidget(this.textEditingController, this.assetPath,
      {super.key,
      this.enable = true,
      this.readOnly = false,
      this.suffixPath = "",
      this.hintText = "",
      this.large = true});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: large ? AppTextStyles().largeBlack : AppTextStyles().smallBlack,
      textAlign: TextAlign.start,
      readOnly: readOnly,
      enabled: enable,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(229, 229, 229, 1),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(229, 229, 229, 1),
          ),
        ),
        hintStyle:
            large ? AppTextStyles().largeGrey : AppTextStyles().smallGrey,
        prefixIcon: CustomIcon(assetPath),
        suffixIcon: suffixPath.isNotEmpty ? CustomIcon(suffixPath) : null,
        isDense: true, // important line
        contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(229, 229, 229, 1)),
        ),
      ),
    );
  }
}

import 'package:employee_management/core/theme/app_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final double radius;

  // 0 for cancel, 1 for save
  final VoidCallback callback;
  const CustomButton(this.callback, this.text,
      {this.backgroundColor = const Color.fromARGB(255, 209, 232, 247),
      this.textColor = const Color.fromRGBO(29, 161, 242, 1),
      this.radius = 5.0,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40,
        constraints: const BoxConstraints(minWidth: 100),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles()
                .smallBlack
                .copyWith(color: textColor, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      onTap: () {
        callback();
      },
    );
  }
}

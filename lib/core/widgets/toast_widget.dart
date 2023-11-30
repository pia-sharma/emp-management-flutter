import 'package:employee_management/core/theme/app_style.dart';
import 'package:flutter/material.dart';

class ToastMessageWidget extends StatelessWidget {
  final String text;
  const ToastMessageWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 40,
        color: AppColors().appBlackColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: AppTextStyles()
                    .smallBlack
                    .copyWith(color: AppColors().white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

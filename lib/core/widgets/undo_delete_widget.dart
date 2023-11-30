import 'package:employee_management/core/theme/app_style.dart';
import 'package:flutter/material.dart';

class UndoDeletedRecordWidget extends StatelessWidget {
  final VoidCallback voidCallback;
  const UndoDeletedRecordWidget(this.voidCallback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: const Color.fromRGBO(50, 50, 56, 1),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Employee data has been deleted",
              style: AppTextStyles()
                  .mediumBlack
                  .copyWith(color: AppColors().white),
            ),
            GestureDetector(
              child: Text(
                "Undo",
                style: AppTextStyles()
                    .mediumBlack
                    .copyWith(color: AppColors().primaryColor),
              ),
              onTap: () {
                voidCallback();
              },
            ),
          ],
        ),
      ),
    );
  }
}

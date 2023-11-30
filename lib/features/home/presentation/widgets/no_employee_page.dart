import 'package:employee_management/core/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoEmployeePage extends StatelessWidget {
  const NoEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 180,
              child: SvgPicture.asset("assets/no_employee.svg",
                  semanticsLabel: ''),
            ),
            Text(
              "No employee records found",
              style: AppTextStyles()
                  .title
                  .copyWith(color: AppColors().appBlackColor),
            )
          ],
        ),
      ),
    );
  }
}

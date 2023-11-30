import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  Color white = Colors.white;
  Color primaryColor = const Color.fromRGBO(29, 161, 242, 1);
  Color appBlackColor = const Color.fromRGBO(50, 50, 56, 1);
  Color applightGrey = const Color.fromRGBO(148, 156, 158, 1);
  Color appSecondaryButtonColor = const Color.fromRGBO(237, 248, 255, 1);
}

class AppTextStyles {
  TextStyle get title {
    return TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: "Roboto",
        fontSize: 18,
        color: AppColors().white);
  }

  TextStyle get header {
    return TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        fontSize: 16,
        color: AppColors().primaryColor);
  }

  TextStyle get smallGrey {
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: 14,
        color: AppColors().applightGrey);
  }

  TextStyle get smallBlack {
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: 14,
        color: AppColors().appBlackColor);
  }

  TextStyle get mediumGrey {
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: 15,
        color: AppColors().applightGrey);
  }

  TextStyle get mediumBlack {
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: 15,
        color: AppColors().appBlackColor);
  }

  TextStyle get largeGrey {
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: 16,
        color: AppColors().applightGrey);
  }

  TextStyle get largeBlack {
    return TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: 16,
        color: AppColors().appBlackColor);
  }
}

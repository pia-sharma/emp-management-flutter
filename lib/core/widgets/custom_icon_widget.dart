import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {
  final String assetPath;
  const CustomIcon(this.assetPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: Padding(
        padding: const EdgeInsets.only(left: 11, right: 13),
        child: SvgPicture.asset(assetPath),
      ),
    );
  }
}

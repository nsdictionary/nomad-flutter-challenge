import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/sizes.dart';

class SubIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  const SubIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.size24,
      height: Sizes.size24,
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: Colors.white,
          )),
      child: Center(
        child: FaIcon(
          icon,
          size: Sizes.size12,
          color: iconColor,
        ),
      ),
    );
  }
}

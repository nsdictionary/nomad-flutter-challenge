import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../constants/sizes.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: Sizes.size20,
          child: RandomAvatar(
            DateTime.now().toIso8601String(),
          ),
        ),
        Positioned(
          bottom: -Sizes.size7,
          right: -Sizes.size6,
          child: Container(
            width: Sizes.size24,
            height: Sizes.size24,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Sizes.size20)),
          ),
        ),
        const Positioned(
          bottom: -Sizes.size5,
          right: -Sizes.size5,
          child: FaIcon(
            FontAwesomeIcons.circlePlus,
            size: Sizes.size20,
          ),
        )
      ],
    );
  }
}

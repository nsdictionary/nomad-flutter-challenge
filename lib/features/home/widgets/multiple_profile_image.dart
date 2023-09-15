import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../constants/sizes.dart';

class MultipleProfileImage extends StatelessWidget {
  final int maxIdx;
  const MultipleProfileImage({
    super.key,
    required this.maxIdx,
  });

  @override
  Widget build(BuildContext context) {
    return maxIdx == 2
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < maxIdx; i++)
                Align(
                  widthFactor: 0.7,
                  child: CircleAvatar(
                    radius: Sizes.size12,
                    child: RandomAvatar(
                      DateTime.now().toIso8601String(),
                    ),
                  ),
                )
            ],
          )
        : SizedBox(
            width: 50,
            height: 30,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: -Sizes.size2,
                  top: Sizes.size3,
                  child: CircleAvatar(
                    radius: Sizes.size10,
                    child: RandomAvatar(
                      DateTime.now().toIso8601String(),
                    ),
                  ),
                ),
                Positioned(
                  top: -Sizes.size3,
                  right: -Sizes.size3,
                  child: CircleAvatar(
                    radius: Sizes.size14,
                    child: RandomAvatar(
                      DateTime.now().toIso8601String(),
                    ),
                  ),
                ),
                Positioned(
                  top: Sizes.size24,
                  left: Sizes.size16,
                  child: CircleAvatar(
                    radius: Sizes.size8,
                    child: RandomAvatar(
                      DateTime.now().toIso8601String(),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

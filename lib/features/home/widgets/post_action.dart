import 'package:flutter/material.dart';
import 'package:navigation_time/features/home/widgets/report.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class PostAction extends StatelessWidget {
  const PostAction({super.key});

  void _onTapReport(BuildContext context) async {
    Navigator.pop(context);
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true, // true로 해야 bottom sheet의 사이즈 변경 가능
      backgroundColor: Colors.transparent,
      builder: (context) => const Report(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 250,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Gaps.v10,
            Center(
              child: Container(
                width: Sizes.size48,
                height: Sizes.size6,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(Sizes.size10),
                ),
              ),
            ),
            Gaps.v20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.9,
                  height: Sizes.size80,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(Sizes.size10),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: Sizes.size10,
                          top: Sizes.size12,
                        ),
                        child: Text(
                          'Unfollow',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Sizes.size10,
                          bottom: Sizes.size12,
                        ),
                        child: Text(
                          'Mute',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gaps.v20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.9,
                  height: Sizes.size80,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(Sizes.size10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: Sizes.size10,
                          top: Sizes.size12,
                        ),
                        child: Text(
                          'Hide',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Sizes.size10,
                          bottom: Sizes.size12,
                        ),
                        child: GestureDetector(
                          onTap: () => _onTapReport(context),
                          child: const Text(
                            'Report',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.size16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

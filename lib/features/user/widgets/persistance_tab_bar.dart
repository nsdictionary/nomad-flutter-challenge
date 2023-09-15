import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/view_model/dark_mode_vm.dart';
import '../../../constants/sizes.dart';

class PersistentTapBar extends SliverPersistentHeaderDelegate {
  final WidgetRef ref;

  PersistentTapBar(this.ref);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
          color: ref.watch(darkModeProvider).darkMode
              ? Colors.black
              : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          )),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
        labelPadding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        labelColor:
            ref.watch(darkModeProvider).darkMode ? Colors.white : Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Text(
              'Threads',
              style: TextStyle(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Text(
              'Replies',
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 39;

  @override
  double get minExtent => 39;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

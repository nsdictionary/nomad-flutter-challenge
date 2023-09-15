import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time/constants/gaps.dart';
import 'package:navigation_time/constants/sizes.dart';
import 'package:navigation_time/features/settings/settings_screen.dart';
import 'package:navigation_time/features/user/widgets/persistance_tab_bar.dart';
import 'package:navigation_time/features/user/widgets/thread_list.dart';
import 'package:navigation_time/utils.dart';
import 'package:random_avatar/random_avatar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static String routeURL = "/profile";
  static String routeName = "profile";
  const UserProfileScreen({super.key});

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  final faker = Faker();
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  elevation: 0,
                  leading: const Center(
                    child: Icon(FontAwesomeIcons.globe),
                  ),
                  actions: [
                    const Center(
                      child: FaIcon(
                        FontAwesomeIcons.instagram,
                      ),
                    ),
                    Gaps.h20,
                    GestureDetector(
                      onTap: () {
                        Utils.animationRoute(context, const SettingsScreen());
                      },
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.gear,
                        ),
                      ),
                    ),
                    Gaps.h10,
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size10,
                      vertical: Sizes.size12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Jane',
                                  style: TextStyle(
                                    fontSize: Sizes.size28,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'jane_mobbin',
                                      style: TextStyle(
                                        fontSize: Sizes.size14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Gaps.h4,
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Sizes.size5,
                                        vertical: Sizes.size4,
                                      ),
                                      width: Sizes.size80,
                                      height: Sizes.size24,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(
                                          Sizes.size10,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'threads.net',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: Sizes.size12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            CircleAvatar(
                              radius: Sizes.size24,
                              child: RandomAvatar('samuelryu'),
                            ),
                          ],
                        ),
                        Gaps.v10,
                        const Text('Plant enthusiast!'),
                        Gaps.v10,
                        Row(
                          children: [
                            SizedBox(
                              width: Sizes.size36,
                              height: Sizes.size24,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    top: Sizes.size3,
                                    left: -Sizes.size2,
                                    child: CircleAvatar(
                                      radius: Sizes.size10,
                                      child: RandomAvatar('follower1'),
                                    ),
                                  ),
                                  Positioned(
                                    top: Sizes.size3,
                                    right: Sizes.size4,
                                    child: CircleAvatar(
                                      radius: Sizes.size10,
                                      child: RandomAvatar('follower2'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gaps.h5,
                            const Text(
                              '2 followers',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        Gaps.v10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            makeProfileButton('EditProfile'),
                            makeProfileButton('Replies'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentTapBar(ref),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                ThreadList(
                  faker: faker,
                  renderReplies: false,
                ),
                ThreadList(
                  faker: faker,
                  renderReplies: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container makeProfileButton(String buttonText) {
    return Container(
      width: 180,
      height: Sizes.size36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size8,
        ),
        border: Border.all(
          width: Sizes.size1,
          color: Colors.black12,
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

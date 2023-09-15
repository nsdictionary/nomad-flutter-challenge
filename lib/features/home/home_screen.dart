import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time/features/home/widgets/post_action.dart';

import '../../common/view_model/dark_mode_vm.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import 'widgets/multiple_profile_image.dart';
import 'widgets/profile_image.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String routeURL = "/";
  static String routeName = "home";
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final faker = Faker();

  final Random random = Random();

  void _onMoreTap(BuildContext context) async {
    await showModalBottomSheet(
      // showDragHandle: true,
      context: context,
      isScrollControlled: true, // true로 해야 bottom sheet의 사이즈 변경 가능
      backgroundColor: Colors.transparent,
      builder: (context) => const PostAction(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/threads.svg',
          width: Sizes.size36,
          color: ref.watch(darkModeProvider).darkMode
              ? Colors.white
              : Colors.black,
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          itemBuilder: (context, index) => IntrinsicHeight(
            // VerticalDivider 반응형으로 할때 Row는 height가 없어서 Row를 IntrinsicHeight로 감싸줌
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const ProfileImage(),
                      Gaps.v5,
                      const Expanded(
                        child: VerticalDivider(
                          thickness: Sizes.size1,
                          color: Colors.black26,
                        ),
                      ),
                      Gaps.v5,
                      MultipleProfileImage(
                        maxIdx: random.nextInt(2) + 2,
                      ),
                    ],
                  ),
                ),
                Gaps.h10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  faker.person.name(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Sizes.size14,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                Gaps.h5,
                                FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  color: Colors.blue.shade300,
                                  size: Sizes.size16,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${20 ~/ (20 - index)}h',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Gaps.h10,
                          GestureDetector(
                            onTap: () => _onMoreTap(context),
                            child: const Icon(
                              Icons.more_horiz,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v3,
                      Text(
                        faker.lorem.sentence(),
                        style: const TextStyle(
                          fontSize: Sizes.size12,
                        ),
                      ),
                      Gaps.v7,
                      if (random.nextBool())
                        Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) => Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size16),
                                  ),
                                  child: Image.network(
                                    faker.image.image(random: true),
                                  ),
                                ),
                                separatorBuilder: (context, index) => Gaps.h10,
                              ),
                            ),
                            Gaps.v10
                          ],
                        ),
                      const Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size20,
                          ),
                          Gaps.h7,
                          Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: Sizes.size20,
                          ),
                          Gaps.h7,
                          FaIcon(
                            FontAwesomeIcons.arrowsRotate,
                            size: Sizes.size20,
                          ),
                          Gaps.h7,
                          FaIcon(
                            FontAwesomeIcons.paperPlane,
                            size: Sizes.size20,
                          ),
                        ],
                      ),
                      Gaps.v10,
                      Row(
                        children: [
                          Text(
                            '${random.nextInt(100) + 1} replies · ${random.nextInt(100) + 1} likes',
                            style: TextStyle(
                              fontSize: Sizes.size14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Gaps.h10,
              ],
            ),
          ),
          separatorBuilder: (context, index) => const Column(
            children: [
              Gaps.v10,
              Divider(
                thickness: Sizes.size1,
              ),
              Gaps.v10,
            ],
          ),
          itemCount: 20,
        ),
      ),
    );
  }
}

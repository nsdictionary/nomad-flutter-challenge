import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../common/view_model/dark_mode_vm.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class ThreadList extends ConsumerStatefulWidget {
  const ThreadList({
    super.key,
    required this.faker,
    required this.renderReplies,
  });

  final Faker faker;
  final bool renderReplies;

  @override
  ThreadListState createState() => ThreadListState();
}

class ThreadListState extends ConsumerState<ThreadList> {
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? Sizes.size20 : Sizes.size10,
                  bottom: Sizes.size10,
                  left: Sizes.size10,
                  right: Sizes.size10,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: Sizes.size6,
                      ),
                      child: widget.renderReplies
                          ? Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: Sizes.size14,
                                  child: RandomAvatar(
                                    DateTime.now().toIso8601String(),
                                  ),
                                ),
                                Gaps.v5,
                                Expanded(
                                  child: VerticalDivider(
                                    thickness: Sizes.size1,
                                    color: ref.watch(darkModeProvider).darkMode
                                        ? Colors.grey.shade800
                                        : Colors.black26,
                                  ),
                                ),
                                Gaps.v5,
                                CircleAvatar(
                                  radius: Sizes.size12,
                                  child: RandomAvatar(
                                    DateTime.now().toIso8601String(),
                                  ),
                                ),
                                Gaps.v24,
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: Sizes.size14,
                                  child: RandomAvatar(
                                    DateTime.now().toIso8601String(),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      widget.faker.person.name(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Sizes.size14,
                                        color:
                                            ref.watch(darkModeProvider).darkMode
                                                ? Colors.white
                                                : Colors.black,
                                      ),
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
                              const Icon(
                                Icons.more_horiz,
                              )
                            ],
                          ),
                          Gaps.v3,
                          Text(
                            widget.faker.lorem.sentence(),
                            style: const TextStyle(
                              fontSize: Sizes.size12,
                            ),
                          ),
                          Gaps.v7,
                          if (index == 1 || (index > 2 && random.nextBool()))
                            Column(
                              children: [
                                FractionallySizedBox(
                                  widthFactor: 1,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Sizes.size10,
                                      horizontal: Sizes.size12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size10,
                                      ),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: Sizes.size12,
                                              child: RandomAvatar(
                                                DateTime.now()
                                                    .toIso8601String(),
                                              ),
                                            ),
                                            Gaps.h5,
                                            Text(
                                              widget.faker.person.name(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Sizes.size12,
                                                color: ref
                                                        .watch(darkModeProvider)
                                                        .darkMode
                                                    ? Colors.white
                                                    : Colors.black,
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
                                        Gaps.v5,
                                        Text(
                                          faker.lorem.sentence(),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: Sizes.size12,
                                          ),
                                        ),
                                        if (widget.renderReplies
                                            ? (index > 2 && random.nextBool())
                                            : (index == 1 || random.nextBool()))
                                          Column(
                                            children: [
                                              Gaps.v10,
                                              SizedBox(
                                                height: 200,
                                                child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: 3,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Container(
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Sizes.size16),
                                                    ),
                                                    child: Image.network(
                                                      faker.image
                                                          .image(random: true),
                                                    ),
                                                  ),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          Gaps.h10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        Gaps.v10,
                                        Text(
                                          '${random.nextInt(200) + 10} replies',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          Gaps.v10,
                          makeActionIconsRow(),
                          if (widget.renderReplies)
                            IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gaps.v24,
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          faker.person.name(),
                                          style: const TextStyle(
                                            fontSize: Sizes.size12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${20 ~/ (20 - index)}h',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Gaps.h10,
                                            const Icon(
                                              Icons.more_horiz,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gaps.v5,
                                  Text(
                                    faker.lorem.sentence(),
                                    style: const TextStyle(
                                      fontSize: Sizes.size12,
                                    ),
                                  ),
                                  Gaps.v10,
                                  makeActionIconsRow(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
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
        itemCount: 20);
  }

  Row makeActionIconsRow() {
    return const Row(
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
    );
  }
}

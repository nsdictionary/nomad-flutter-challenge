import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time/constants/gaps.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../common/view_model/dark_mode_vm.dart';
import '../../constants/sizes.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static String routeURL = "/search";
  static String routeName = "search";
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends ConsumerState<SearchScreen> {
  final ScrollController _scrollController = ScrollController();

  final faker = Faker();
  final Random random = Random();
  final listCount = 20;
  List<Map<String, dynamic>> tileDataList = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < listCount; i++) {
      var followerCount =
          faker.randomGenerator.decimal(scale: 150).toStringAsFixed(1);
      if (followerCount.substring(followerCount.length - 2) == '.0') {
        followerCount = followerCount.substring(0, followerCount.length - 2);
      }

      tileDataList.add({
        'followerCount': followerCount,
        'avatar': RandomAvatar(
          DateTime.now().toIso8601String(),
        ),
        'nickname': faker.internet.userName(),
        'username': faker.person.name(),
        'badge': i % 3 == 0 && random.nextBool(),
        'following': i % 4 == 0 && random.nextBool(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: Sizes.size96,
          title: const Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: Sizes.size36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gaps.v5,
              CupertinoSearchTextField()
            ],
          ),
        ),
        body: Scrollbar(
          controller: _scrollController,
          child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                radius: Sizes.size20,
                child: tileDataList[index]['avatar'],
              ),
              title: Row(
                children: [
                  Text(
                    tileDataList[index]['nickname'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.size14,
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
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tileDataList[index]['username'],
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Gaps.v10,
                  Row(
                    children: [
                      if (tileDataList[index]['badge'])
                        const Padding(
                          padding: EdgeInsets.only(
                            right: Sizes.size7,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.circleExclamation,
                            size: Sizes.size16,
                          ),
                        ),
                      Text(
                        '${tileDataList[index]['followerCount']}k followers',
                        style: const TextStyle(),
                      ),
                    ],
                  )
                ],
              ),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    tileDataList[index]['following'] =
                        !tileDataList[index]['following'];
                  });
                },
                child: Container(
                  width: Sizes.size96,
                  height: Sizes.size32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Sizes.size8,
                    ),
                    border: Border.all(
                      width: Sizes.size1,
                      color: ref.watch(darkModeProvider).darkMode
                          ? Colors.white
                          : Colors.black12,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tileDataList[index]['following'] ? 'Unfollow' : 'Follow',
                      style: TextStyle(
                        color: tileDataList[index]['following']
                            ? Colors.grey
                            : ref.watch(darkModeProvider).darkMode
                                ? Colors.white
                                : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(
                left: Sizes.size72,
                top: Sizes.size7,
                bottom: Sizes.size7,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.1,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            itemCount: listCount,
          ),
        ),
      ),
    );
  }
}

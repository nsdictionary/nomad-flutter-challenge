import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time/common/view_model/dark_mode_vm.dart';
import 'package:navigation_time/features/activity/widgets/sub_icon.dart';
import 'package:random_avatar/random_avatar.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

final tabs = [
  "All",
  "Replies",
  "Mentions",
  "Verifications",
  "DirectMessage",
  "Notices",
];

class ActivityScreen extends ConsumerStatefulWidget {
  static String routeURL = "/activity";
  static String routeName = "activity";
  const ActivityScreen({super.key});

  @override
  ActivityScreenState createState() => ActivityScreenState();
}

class ActivityScreenState extends ConsumerState<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final faker = Faker();

  int _selectedIndex = 0;
  List<Map<String, dynamic>> tileDataList = [];

  void _onTabChanged() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);

    tileDataList = [
      {
        'avatar': RandomAvatar(
          DateTime.now().toIso8601String(),
        ),
        'subIcon': FontAwesomeIcons.sterlingSign,
        'iconColor': Colors.white,
        'iconBgColor': Colors.green,
        'nickname': 'john_mobbin',
        'time_ago': '4h',
        'action': 'Mentioned you',
        'details':
            "Here's a thread you should follow if you love botany @john_mobbin",
        'button': "",
      },
      {
        'avatar': RandomAvatar(
          DateTime.now().toIso8601String(),
        ),
        'subIcon': FontAwesomeIcons.handBackFist,
        'iconColor': Colors.white,
        'iconBgColor': Colors.blue.shade300,
        'nickname': 'john_mobbin',
        'time_ago': '4h',
        'action': 'Starting out my gardening club with three promotions!',
        'details': "Count me in!",
        'button': "",
      },
      {
        'avatar': RandomAvatar(
          DateTime.now().toIso8601String(),
        ),
        'subIcon': FontAwesomeIcons.solidUser,
        'iconColor': Colors.white,
        'iconBgColor': Colors.purple.shade800,
        'nickname': 'the.plantdads',
        'time_ago': '5h',
        'action': 'Followed you',
        'details': "",
        'button': "Following",
      },
      {
        'avatar': RandomAvatar(
          DateTime.now().toIso8601String(),
        ),
        'subIcon': FontAwesomeIcons.heartCirclePlus,
        'iconColor': Colors.white,
        'iconBgColor': Colors.red,
        'nickname': 'the.plantdads',
        'time_ago': '5h',
        'action': 'Definitely broken! 🧵👀☘️',
        'details': "",
        'button': "",
      },
      {
        'avatar': RandomAvatar(
          DateTime.now().toIso8601String(),
        ),
        'subIcon': FontAwesomeIcons.heartCirclePlus,
        'iconColor': Colors.white,
        'iconBgColor': Colors.red,
        'nickname': 'the.plantdads',
        'time_ago': '5h',
        'action': '',
        'details': "🧵👀☘️",
        'button': "",
      },
    ];
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activity',
          style: TextStyle(
            fontSize: Sizes.size36,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
          ),
          splashFactory: NoSplash.splashFactory,
          isScrollable: true,
          labelPadding: const EdgeInsets.symmetric(
            horizontal: Sizes.size5,
          ),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size16,
          ),
          indicatorColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: [
            for (final (index, tab) in tabs.indexed)
              Container(
                width: Sizes.size96 + Sizes.size32,
                height: Sizes.size44,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size10,
                ),
                decoration: BoxDecoration(
                  color: index == _selectedIndex ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(
                    Sizes.size8,
                  ),
                  border: Border.all(
                    width: Sizes.size1,
                    color: index == _selectedIndex
                        ? ref.watch(darkModeProvider).darkMode
                            ? Colors.white
                            : Colors.black
                        : Colors.grey.shade400,
                  ),
                ),
                child: Tab(text: tab),
              ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.separated(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size10,
              ),
              child: ListTile(
                leading: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: Sizes.size20,
                      child: tileDataList[index]['avatar'],
                    ),
                    Positioned(
                      bottom: -Sizes.size7,
                      right: -Sizes.size6,
                      child: SubIcon(
                        icon: tileDataList[index]['subIcon'],
                        iconColor: tileDataList[index]['iconColor'],
                        backgroundColor: tileDataList[index]['iconBgColor'],
                      ),
                    )
                  ],
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          tileDataList[index]['nickname'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size14,
                            color: ref.watch(darkModeProvider).darkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Gaps.h5,
                        Text(
                          tileDataList[index]['time_ago'],
                          style: TextStyle(
                            fontSize: Sizes.size14,
                            color: ref.watch(darkModeProvider).darkMode
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v3,
                    tileDataList[index]['action'] != ''
                        ? Text(
                            tileDataList[index]['action'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Sizes.size14,
                              color: ref.watch(darkModeProvider).darkMode
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          )
                        : const SizedBox(width: 0)
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v3,
                    Text(
                      tileDataList[index]['details'],
                      style: TextStyle(
                        color: ref.watch(darkModeProvider).darkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
                trailing: tileDataList[index]['button'] != ''
                    ? Container(
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
                            'Following',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(width: 0),
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
            itemCount: 5,
          ),
          for (var tab in tabs.skip(1))
            Center(
              child: Text(
                tab,
                style: const TextStyle(fontSize: Sizes.size28),
              ),
            )
        ],
      ),
    );
  }
}

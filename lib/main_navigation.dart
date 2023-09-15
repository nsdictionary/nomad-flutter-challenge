import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_time/features/activity/activity_screen.dart';
import 'package:navigation_time/features/home/home_screen.dart';
import 'package:navigation_time/features/search/search_screen.dart';
import 'package:navigation_time/features/user/user_profile_screen.dart';
import 'package:navigation_time/features/write/write_screen.dart';

class MainNavigation extends StatefulWidget {
  static const String routeName = "mainNavigation";
  final String tab;

  const MainNavigation({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final List<String> _tabs = [
    "home",
    "search",
    "xxxx",
    "activity",
    "profile",
  ];
  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) async {
    if (_selectedIndex == index) return;

    if (index == 2) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const WriteScreen(),
      );
    } else {
      if (index == 0) {
        context.go("/");
      } else {
        context.go("/${_tabs[index]}");
      }
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const SearchScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const ActivityScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: 'home',
          ),
          const BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
            ),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              _selectedIndex == 2
                  ? FontAwesomeIcons.solidPenToSquare
                  : FontAwesomeIcons.penToSquare,
            ),
            label: 'post',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              _selectedIndex == 3
                  ? FontAwesomeIcons.solidHeart
                  : FontAwesomeIcons.heart,
            ),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              _selectedIndex == 4
                  ? FontAwesomeIcons.solidUser
                  : FontAwesomeIcons.user,
            ),
            label: 'user',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        onTap: _onTap,
      ),
    );
  }
}

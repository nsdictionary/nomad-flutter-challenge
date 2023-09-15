import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class PrivacyScreen extends StatefulWidget {
  static String routeURL = "privacy";
  static String routeName = "privacy";
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _privateProfile = false;

  void _onPrivateProfileChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _privateProfile = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy',
          style: TextStyle(),
        ),
        leadingWidth: 80,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: Sizes.size18,
              ),
              Gaps.h3,
              Text(
                'Back',
                style: TextStyle(
                  fontSize: Sizes.size20,
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: _privateProfile,
            onChanged: _onPrivateProfileChanged,
            title: const Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.lock,
                ),
                Gaps.h32,
                Gaps.h3,
                Text('Private profile'),
              ],
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.at,
            ),
            title: Text(
              'Mentions',
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  Text(
                    'Everyone',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Gaps.h12,
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.grey,
                    size: Sizes.size20,
                  )
                ],
              ),
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.bellSlash,
            ),
            title: Text(
              'Muted',
            ),
            trailing: SizedBox(
              width: 30,
              child: FaIcon(
                FontAwesomeIcons.chevronRight,
                color: Colors.grey,
                size: Sizes.size20,
              ),
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.eyeSlash,
            ),
            title: Text(
              'Hidden Words',
            ),
            trailing: SizedBox(
              width: 30,
              child: FaIcon(
                FontAwesomeIcons.chevronRight,
                color: Colors.grey,
                size: Sizes.size20,
              ),
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.users,
            ),
            title: Text(
              'Profile you follow',
            ),
            trailing: SizedBox(
              width: 30,
              child: FaIcon(
                FontAwesomeIcons.chevronRight,
                color: Colors.grey,
                size: Sizes.size20,
              ),
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text(
              'Other privacy settings',
            ),
            subtitle: Text(
              'Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            trailing: SizedBox(
              width: 30,
              child: FaIcon(
                FontAwesomeIcons.upRightFromSquare,
                color: Colors.grey,
                size: Sizes.size20,
              ),
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.circleXmark,
            ),
            title: Text(
              'Blocked profiles',
            ),
            trailing: SizedBox(
              width: 30,
              child: FaIcon(
                FontAwesomeIcons.upRightFromSquare,
                color: Colors.grey,
                size: Sizes.size20,
              ),
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.heartCircleXmark,
            ),
            title: Text(
              'Hide likes',
            ),
            trailing: SizedBox(
              width: 30,
              child: FaIcon(
                FontAwesomeIcons.upRightFromSquare,
                color: Colors.grey,
                size: Sizes.size20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

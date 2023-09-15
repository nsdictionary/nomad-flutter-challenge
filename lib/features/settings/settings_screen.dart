import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time/common/view_model/dark_mode_vm.dart';
import 'package:navigation_time/constants/gaps.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:navigation_time/features/settings/privacy_screen.dart';
import 'package:navigation_time/utils.dart';

import '../../common/widgets/dark_mode_config.dart';
import '../../constants/sizes.dart';

class SettingsScreen extends ConsumerWidget {
  static String routeURL = "/settings";
  static String routeName = "settings";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
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
          ValueListenableBuilder(
            valueListenable: darkModeConfig,
            builder: (context, value, child) => SwitchListTile.adaptive(
              value: ref.watch(darkModeProvider).darkMode,
              onChanged: (value) {
                ref.read(darkModeProvider.notifier).setDarkMode(value);
              },
              title: const Text("Dark mode"),
              subtitle: const Text("enable dark mode"),
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.userPlus,
            ),
            title: Text(
              'Follow and invite friends',
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.bell,
            ),
            title: Text(
              'Notifications',
            ),
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.lock,
            ),
            title: const Text(
              'Privacy',
            ),
            onTap: () {
              Utils.animationRoute(context, const PrivacyScreen());
            },
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.circleUser,
            ),
            title: Text(
              'Account',
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.lifeRing,
            ),
            title: Text(
              'Help',
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.circleInfo,
            ),
            title: Text(
              'About',
            ),
          ),
          const Divider(),
          foundation.defaultTargetPlatform == foundation.TargetPlatform.android
              ? ListTile(
                  title: const Text('Log out'),
                  textColor: Colors.blue,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Aur you sure?'),
                        content: const Text("Plz don't go"),
                        actions: [
                          // Whatever you want
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('No'),
                          )
                        ],
                      ),
                    );
                  },
                )
              : ListTile(
                  title: const Text('Log out'),
                  textColor: Colors.blue,
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Aur you sure?'),
                        content: const Text("Plz don't go"),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('No'),
                          ),
                          CupertinoDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            isDestructiveAction: true,
                            child: const Text('Yes'),
                          )
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

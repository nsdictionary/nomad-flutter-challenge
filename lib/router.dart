import 'package:go_router/go_router.dart';
import 'package:navigation_time/features/home/home_screen.dart';
import 'package:navigation_time/features/settings/privacy_screen.dart';
import 'package:navigation_time/features/settings/settings_screen.dart';
import 'package:navigation_time/main_navigation.dart';
import 'package:navigation_time/utils.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: HomeScreen.routeName,
      path: HomeScreen.routeURL,
      pageBuilder: (context, state) => Utils.animationPage(
        state,
        const MainNavigation(
          tab: 'home',
        ),
      ),
    ),
    GoRoute(
        name: SettingsScreen.routeName,
        path: SettingsScreen.routeURL,
        pageBuilder: (context, state) => Utils.animationPage(
              state,
              const SettingsScreen(),
            ),
        routes: [
          GoRoute(
            name: PrivacyScreen.routeName,
            path: PrivacyScreen.routeURL,
            pageBuilder: (context, state) {
              return Utils.animationPage(
                state,
                const PrivacyScreen(),
              );
            },
          )
        ]),
    GoRoute(
      path: "/:tab(home|search|activity|profile|setting)",
      name: MainNavigation.routeName,
      pageBuilder: (context, state) {
        final tab = state.pathParameters["tab"]!;

        return Utils.animationPage(
          state,
          MainNavigation(tab: tab),
        );
      },
    ),
  ],
);

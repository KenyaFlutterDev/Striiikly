import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:striiikly/core/common/constants/app_strings.dart';
import 'package:striiikly/core/common/constants/routes.dart';
import 'package:striiikly/core/common/presentation/bloc/theme_bloc.dart';
import 'package:striiikly/core/common/presentation/widgets/scaffold_with_navbar.dart';
import 'package:striiikly/features/achievements/presentation/pages/achievement_page.dart';
import 'package:striiikly/features/contributions/presentation/pages/contributions_page.dart';
import 'package:striiikly/features/leaderboard/presentation/pages/leaderboard_page.dart';
import 'package:striiikly/features/notifications/presentation/pages/notifications_page.dart';
import 'package:striiikly/features/teams/presentation/pages/teams_page.dart';
import 'package:striiikly/themes/theme.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

// Set up nested navigation using ShellRoute,
// which is a pattern where an additional Navigator is placed in the widget tree
// to be used instead of the root navigator. This allows deep-links to display
// pages along with other UI components such as a BottomNavigationBar.
//
// Display a route within a ShellRoute and also
// push a screen using a different navigator (such as the root Navigator) by
// providing a `parentNavigatorKey`.

///  How to use [ShellRoute]

class App extends StatelessWidget {
  /// Creates a [App]
  App({super.key}) {
    //checkForUpdate();
  }

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,

    // initialLocation:
    // initialLocation: home_page_route,
    initialLocation: leaderboard_page_route,

    routes: <RouteBase>[
      /// Application shell
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
          return NoTransitionPage(child: ScaffoldWithNavBar(child: child));
        },
        routes: <RouteBase>[
          /// The first screen to display in the bottom navigation bar.

          //Modern Home Page.
          GoRoute(
            path: leaderboard_page_route,
            builder: (BuildContext context, GoRouterState state) {
              return const LeaderboardPage();
            },
          ),
          GoRoute(
            path: teams_page_route,
            builder: (BuildContext context, GoRouterState state) {
              return const TeamsPage();
            },
          ),

          //Local Songs
          GoRoute(
            path: contributions_page_route,
            builder: (BuildContext context, GoRouterState state) {
              return const ContributionsPage();
            },
          ),
          GoRoute(
            path: achievements_page_route,
            builder: (BuildContext context, GoRouterState state) {
              return const AchievementPage();
            },
          ),
           GoRoute(
            path: achievements_page_route,
            builder: (BuildContext context, GoRouterState state) {
              return const NotificationsPage();
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final themestate = (state as AppThemeState).theme;
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: app_title,
          theme: AppTheme.main(Brightness.light),
          darkTheme: AppTheme.main(Brightness.dark),
          themeMode: switch (themestate) {
            SwitchableAppTheme.light => ThemeMode.light,
            SwitchableAppTheme.dark => ThemeMode.dark,
            SwitchableAppTheme.system => ThemeMode.system,
          },
          // Switches automatically based on system setting
          routerConfig: _router,
        );
      },
    );
  }
}

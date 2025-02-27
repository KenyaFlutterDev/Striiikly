import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:striiikly/core/common/constants/app_strings.dart';
import 'package:striiikly/core/common/constants/routes.dart';
import 'package:striiikly/core/common/data/datasources/local/storage_utils.dart';
import 'package:striiikly/core/common/di/injection.dart';
import 'package:striiikly/core/common/presentation/widgets/bottom_menu_icon.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({required this.child, super.key});

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is home Navigator.
  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();

  static int _calculateSelectedIndex(
    BuildContext context,
    String? homePageIndex,
  ) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(leaderboard_page_route)) {
      return 0;
    }
    if (location.startsWith(teams_page_route)) {
      return 1;
    }
    if (location.startsWith(contributions_page_route)) {
      return 2;
    }
    if (location.startsWith(achievements_page_route)) {
      return 3;
    }

    return 0;
  }
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar>
    with WidgetsBindingObserver {
  String? homePageIndex;

  @override
  void initState() {
    _getCurrentHomePageTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        selectedLabelStyle: const TextStyle(
          letterSpacing: 0,
          height: 0,
          fontSize: 0,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: BottomMenuIcon(
              assetsvgicon: leaderboard_icon,
              iconlabel: leaderboard_label,
              isActive: true,
            ),
            icon: BottomMenuIcon(
              assetsvgicon: leaderboard_icon,
              iconlabel: leaderboard_label,
              isActive: false,
            ),
            label: leaderboard_label,
          ),
          BottomNavigationBarItem(
            activeIcon: BottomMenuIcon(
              assetsvgicon: teams_icon,
              iconlabel: teams_label,
              isActive: true,
            ),
            icon: BottomMenuIcon(
              assetsvgicon: teams_icon,
              iconlabel: teams_label,
              isActive: false,
            ),
            label: teams_label,
          ),
          BottomNavigationBarItem(
            activeIcon: BottomMenuIcon(
              assetsvgicon: contributions_icon,
              iconlabel: contributions_label,
              isActive: true,
            ),
            icon: BottomMenuIcon(
              assetsvgicon: contributions_icon,
              iconlabel: contributions_label,
              isActive: false,
            ),
            label: contributions_label,
          ),
          BottomNavigationBarItem(
            activeIcon: BottomMenuIcon(
              assetsvgicon: achievements_icon,
              iconlabel: achievements_label,
              isActive: true,
            ),
            icon: BottomMenuIcon(
              assetsvgicon: achievements_icon,
              iconlabel: achievements_label,
              isActive: false,
            ),
            label: achievements_label,
          ),
        ],
        currentIndex: ScaffoldWithNavBar._calculateSelectedIndex(
          context,
          homePageIndex,
        ),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    _getCurrentHomePageTheme();

    switch (index) {
      case 0:
        GoRouter.of(context).go(leaderboard_page_route);
        break;
      case 1:
        GoRouter.of(context).go(teams_page_route);
        break;
      case 2:
        GoRouter.of(context).go(contributions_page_route);
        break;
      case 3:
        GoRouter.of(context).go(achievements_page_route);
        break;
    }
  }

  void _getCurrentHomePageTheme() async {
    homePageIndex = await getIt<StorageUtils>().getDataForSingle(
      key: home_page_theme_key,
    );
  }
}

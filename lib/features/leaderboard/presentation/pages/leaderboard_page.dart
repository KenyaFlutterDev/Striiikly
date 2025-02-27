import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striiikly/core/common/constants/dimens.dart';
import 'package:striiikly/core/common/presentation/bloc/theme_bloc.dart';
import 'package:striiikly/core/common/utils/app_utils.dart';
import 'package:striiikly/features/leaderboard/presentation/widgets/app_textview_medium.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        actionsPadding: EdgeInsets.all(app_padding),
        actions: [
          InkWell(
            onTap: () {
              showBottomSheetForm(
                context: context,
                view: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: app_large_padding),
                    const AppTextViewMedium(
                      text: 'Select Prefered Theme',
                      fontSize: 22,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: app_large_padding),
                    AppTextViewMedium(
                      text: 'Light',
                      textAlign: TextAlign.start,
                      onClick: () => _toggleTheme(SwitchableAppTheme.light),
                    ),
                    const SizedBox(height: app_large_padding),
                    AppTextViewMedium(
                      text: 'Dark',
                      textAlign: TextAlign.start,
                      onClick: () => _toggleTheme(SwitchableAppTheme.dark),
                    ),
                    const SizedBox(height: app_large_padding),
                    AppTextViewMedium(
                      text: 'System',
                      textAlign: TextAlign.start,
                      onClick: () => _toggleTheme(SwitchableAppTheme.system),
                    ),
                    const SizedBox(height: app_large_padding),
                  ],
                ),
              );
            },
            child: Icon(Icons.sunny, size: 28),
          ),
        ],
      ),
      body: Center(child: Text('This will be the leaderboard Page')),
    );
  }

  void _toggleTheme(SwitchableAppTheme theme) {
    Navigator.of(context, rootNavigator: true).pop();

    Future.delayed(const Duration(milliseconds: 200), () {
      mounted ? context.read<ThemeBloc>().add(ToggleTheme(theme: theme)) : null;
    });
  }
}

part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class AppThemeState extends ThemeState {
  final SwitchableAppTheme theme;

  const AppThemeState({required this.theme});

  @override
  List<Object> get props => [theme];
}

enum SwitchableAppTheme { light, dark, system }

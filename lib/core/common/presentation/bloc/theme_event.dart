part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {
  final SwitchableAppTheme theme;

  const ToggleTheme({required this.theme});
}

class LoadThemePreference extends ThemeEvent {}

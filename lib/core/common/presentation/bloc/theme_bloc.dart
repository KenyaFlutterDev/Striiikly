import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:striiikly/core/common/data/datasources/local/storage_utils.dart';

part 'theme_event.dart';
part 'theme_state.dart';

@injectable
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final StorageUtils prefs;
  ThemeBloc(this.prefs)
    : super(const AppThemeState(theme: SwitchableAppTheme.system)) {
    on<ToggleTheme>(_onToggleTheme);

    on<LoadThemePreference>(_onLoadThemePreference); // Handle the load event

    // Trigger loading of the theme when the Bloc is created
    add(LoadThemePreference());
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    final theme = switch (event.theme) {
      SwitchableAppTheme.light => 'light',
      SwitchableAppTheme.dark => 'dark',
      SwitchableAppTheme.system => 'syste,',
    };

    await prefs.saveDataForSingle(key: 'app-theme', dataToSave: theme);
    emit(AppThemeState(theme: event.theme));
  }

  Future<void> _onLoadThemePreference(
    LoadThemePreference event,
    Emitter<ThemeState> emit,
  ) async {
    final apptheme = await prefs.getDataForSingle(key: 'app-theme');

    final mtheme = switch (apptheme) {
      'system' => SwitchableAppTheme.system,
      'dark' => SwitchableAppTheme.dark,
      'light' => SwitchableAppTheme.light,
      String() => SwitchableAppTheme.system,
    };

    emit(AppThemeState(theme: mtheme));
  }
}

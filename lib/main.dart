
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:striiikly/app.dart';
import 'package:striiikly/core/common/constants/app_strings.dart';
import 'package:striiikly/core/common/data/datasources/local/storage_utils.dart';
import 'package:striiikly/core/common/di/injection.dart';
import 'package:striiikly/core/common/presentation/widgets/blocs_root.dart';
import 'package:striiikly/core/common/utils/app_global_observer.dart';
import 'package:striiikly/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = kDebugMode;
  if (kDebugMode) {
    await dotenv.load(fileName: '.dev.env');
  } else {
    await dotenv.load(fileName: '.env');
  }

  await configureDependencies();

  if (kDebugMode) {
    Bloc.observer = AppGlobalBlocObserver();
  }

  /// Please add all BloCs ref to [BlocsRoot]
  final apptoken = await getIt<StorageUtils>().getDataForSingle(key: token);
  runApp(BlocsRoot(apptoken: apptoken));
}

class MyApp extends StatelessWidget {
  final String token;
  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: app_title,
      theme: AppTheme.main(Brightness.light),
      darkTheme: AppTheme.main(Brightness.dark),
      themeMode:
          ThemeMode.system, // Switches automatically based on system setting
      home: App(),
    );
  }
}

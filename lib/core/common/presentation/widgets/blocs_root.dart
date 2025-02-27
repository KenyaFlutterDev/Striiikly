import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striiikly/core/common/di/injection.dart';
import 'package:striiikly/core/common/presentation/bloc/theme_bloc.dart';
import 'package:striiikly/main.dart';

class BlocsRoot extends StatelessWidget {
  const BlocsRoot({super.key, required this.apptoken});

  final String apptoken;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<ThemeBloc>())],
      child: MyApp(token: apptoken),
    );
  }
}

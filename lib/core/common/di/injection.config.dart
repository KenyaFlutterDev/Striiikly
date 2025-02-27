// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/services.dart' as _i281;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../data/datasources/local/storage_utils.dart' as _i910;
import '../network/dio_config.dart' as _i150;
import '../presentation/bloc/theme_bloc.dart' as _i869;
import 'module_injection.dart' as _i237;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModules = _$RegisterModules();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModules.prefs,
      preResolve: true,
    );
    gh.singleton<_i281.MethodChannel>(() => registerModules.channel);
    gh.lazySingleton<_i910.StorageUtils>(
      () => _i910.StorageUtils(gh<_i460.SharedPreferences>()),
    );
    gh.factory<String>(() => registerModules.baseUrl, instanceName: 'BaseUrl');
    gh.factory<_i869.ThemeBloc>(
      () => _i869.ThemeBloc(gh<_i910.StorageUtils>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModules.dio(gh<String>(instanceName: 'BaseUrl')),
    );
    gh.lazySingleton<_i150.DioClient>(() => _i150.DioClient(gh<_i361.Dio>()));
    return this;
  }
}

class _$RegisterModules extends _i237.RegisterModules {}

// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i163;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news_hw/core/di/service_locator.dart' as _i446;
import 'package:news_hw/core/service/firebase_service/push_foreground_service.dart'
    as _i1052;
import 'package:news_hw/core/service/storage_service/secure_storage_service.dart'
    as _i385;
import 'package:news_hw/core/service/storage_service/shared_preferences_service.dart'
    as _i407;
import 'package:news_hw/features/auth/data/data_source/abstract/auth_data_source.dart'
    as _i1040;
import 'package:news_hw/features/auth/data/data_source/remote/auth_data_source_impl.dart'
    as _i890;
import 'package:news_hw/features/auth/data/repo/auth_repository_impl.dart'
    as _i375;
import 'package:news_hw/features/auth/domain/repo/auth_repository.dart'
    as _i320;
import 'package:news_hw/features/auth/presentation/cubit/auth_cubit.dart'
    as _i513;
import 'package:news_hw/features/main/presentation/bloc/main_bloc.dart'
    as _i545;
import 'package:news_hw/features/news/data/data_source/abstract/news_data_source.dart'
    as _i662;
import 'package:news_hw/features/news/data/data_source/remote/news_data_source_impl.dart'
    as _i946;
import 'package:news_hw/features/news/data/repository/news_repository_impl.dart'
    as _i696;
import 'package:news_hw/features/news/domain/repository/news_repository.dart'
    as _i618;
import 'package:news_hw/features/news/domain/use_case/get_news_use_case.dart'
    as _i682;
import 'package:news_hw/features/news/presentation/adapter/news_paging_adapter.dart'
    as _i414;
import 'package:news_hw/features/news/presentation/bloc/news_bloc.dart'
    as _i1022;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:talker/talker.dart' as _i993;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.singleton<_i558.FlutterSecureStorage>(
      () => appModule.flutterSecureStorage,
    );
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i993.Talker>(() => appModule.talker);
    gh.singleton<_i892.FirebaseMessaging>(() => appModule.firebaseMessaging);
    gh.singleton<_i163.FlutterLocalNotificationsPlugin>(
      () => appModule.flutterLocalNotificationsPlugin,
    );
    gh.lazySingleton<_i407.SharedPreferencesService>(
      () => _i407.SharedPreferencesService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i385.SecureStorageService>(
      () => _i385.SecureStorageService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i545.MainBloc>(
      () => _i545.MainBloc(
        firebaseMessaging: gh<_i892.FirebaseMessaging>(),
        talker: gh<_i993.Talker>(),
      ),
    );
    gh.singleton<_i361.Dio>(() => appModule.dio(gh<_i993.Talker>()));
    gh.lazySingleton<_i1052.PushForegroundService>(
      () => _i1052.PushForegroundService(
        dio: gh<_i361.Dio>(),
        firebaseMessaging: gh<_i892.FirebaseMessaging>(),
        flutterLocalNotificationsPlugin:
            gh<_i163.FlutterLocalNotificationsPlugin>(),
        talker: gh<_i993.Talker>(),
      ),
    );
    gh.lazySingleton<_i1040.AuthDataSource>(
      () => _i890.AuthDataSourceImpl(
        gh<_i385.SecureStorageService>(),
        talker: gh<_i993.Talker>(),
      ),
    );
    gh.lazySingleton<_i662.NewsDataSource>(
      () => _i946.NewsDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i320.AuthRepository>(
      () => _i375.AuthRepositoryImpl(dataSource: gh<_i1040.AuthDataSource>()),
    );
    gh.lazySingleton<_i618.NewsRepository>(
      () => _i696.NewsRepositoryImpl(dataSource: gh<_i662.NewsDataSource>()),
    );
    gh.lazySingleton<_i682.GetNewsUseCase>(
      () => _i682.GetNewsUseCase(repository: gh<_i618.NewsRepository>()),
    );
    gh.factory<_i513.AuthCubit>(
      () => _i513.AuthCubit(authRepository: gh<_i320.AuthRepository>()),
    );
    gh.factory<_i414.NewsPagingAdapter>(
      () => _i414.NewsPagingAdapter(newsRepository: gh<_i618.NewsRepository>()),
    );
    gh.factory<_i1022.NewsBloc>(
      () => _i1022.NewsBloc(getNews: gh<_i682.GetNewsUseCase>()),
    );
    return this;
  }
}

class _$AppModule extends _i446.AppModule {}

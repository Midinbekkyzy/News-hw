// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news_hw/core/di/service_locator.dart' as _i446;
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
import 'package:news_hw/features/news/presentation/bloc/news_bloc.dart'
    as _i1022;
import 'package:talker/talker.dart' as _i993;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.singleton<_i993.Talker>(() => appModule.talker);
    gh.singleton<_i361.Dio>(() => appModule.dio(gh<_i993.Talker>()));
    gh.lazySingleton<_i662.NewsDataSource>(
      () => _i946.NewsDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i618.NewsRepository>(
      () => _i696.NewsRepositoryImpl(dataSource: gh<_i662.NewsDataSource>()),
    );
    gh.lazySingleton<_i682.GetNewsUseCase>(
      () => _i682.GetNewsUseCase(repository: gh<_i618.NewsRepository>()),
    );
    gh.factory<_i1022.NewsBloc>(
      () => _i1022.NewsBloc(getNews: gh<_i682.GetNewsUseCase>()),
    );
    return this;
  }
}

class _$AppModule extends _i446.AppModule {}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> setupServiceLocator() async => getIt.init();

@module
abstract class AppModule {
  @singleton
  Talker get talker => Talker();

  @singleton
  Dio dio(Talker talker) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestData: true,
          printRequestHeaders: false,
          printResponseData: true,
          printResponseMessage: true,
          printResponseHeaders: true,
          printResponseTime: true,
          hiddenHeaders: {'X-Api-Key'},
        ),
      ),
    );
    return dio;
  }
}

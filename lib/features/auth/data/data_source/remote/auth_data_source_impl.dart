import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_hw/core/service/storage_service/secure_storage_service.dart';
import 'package:news_hw/features/auth/data/data_source/abstract/auth_data_source.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

final class _ApiPath {
  static const String auth = '/auth';
}

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl(this.secureStorageService, {required this.talker});

  final SecureStorageService secureStorageService;
  final Talker talker;

  @override
  Future<bool> auth(String login, String password) async {
    final dio = Dio(
      BaseOptions(baseUrl: 'https://test-ibragim.free.beeceptor.com'),
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

    final response = await dio.post(
      _ApiPath.auth,
      data: {'login': login, 'password': password},
    );

    if (response.statusCode == 200 && response.data != null) {
      final accessToken = response.data['access_token'] as String;
      final refreshToken = response.data['refresh_token'] as String;

      await secureStorageService.save(
        SecureStorageKeys.accessTokenKey,
        accessToken,
      );
      await secureStorageService.save(
        SecureStorageKeys.refreshTokenKey,
        refreshToken,
      );

      return true;
    }

    return false;
  }

  @override
  Future<void> logout() {
    return secureStorageService.deleteAll();
  }
}

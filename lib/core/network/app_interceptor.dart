import 'package:dio/dio.dart';
import 'package:sustina_app/core/constants/api_constants.dart';
import 'package:sustina_app/core/di/service_locator.dart';
import 'package:sustina_app/core/helpers/secure_storage_helper.dart';
import 'package:sustina_app/core/network/token_refresh_manager.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor(this.dio);

  final Dio dio;

  late final TokenRefreshManager refreshManager = TokenRefreshManager(dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getIt<SecureStorageHelper>().getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isRefreshRequest = err.requestOptions.path.contains(
      ApiConstants.refreshToken,
    );
    if (err.response?.statusCode != 401 || isRefreshRequest) {
      return handler.next(err);
    }

    try {
      final newToken = await refreshManager.refreshToken();

      if (newToken == null || newToken.isEmpty) {
        return handler.next(err);
      }

      final requestOptions = err.requestOptions;

      requestOptions.headers['Authorization'] = 'Bearer $newToken';

      final response = await dio.fetch(requestOptions);

      return handler.resolve(response);
    } catch (_) {
      return handler.next(err);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:suatina_web_project/core/di/service_locator.dart';
import 'package:suatina_web_project/core/network/api_result.dart';
import 'package:suatina_web_project/core/network/network_failure.dart';
import 'package:suatina_web_project/core/network/network_manager.dart';

class ApiHandler {
  ApiHandler();

  Future<ApiResult<T>> makeRequest<T>(Future<T> Function() request) async {
    final connected = await getIt<NetworkManager>().isNetworkConnected();
    if (!connected) {
      return const ApiResult.failure(NetworkFailure.noInternet());
    }

    try {
      final result = await request();
      return ApiResult.success(result);
    } on DioException catch (e) {
      return ApiResult.failure(_mapError(e));
    } catch (e) {
      return ApiResult.failure(NetworkFailure.unknown(e.toString()));
    }
  }

  NetworkFailure _mapError(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      if (e.response?.data != null &&
          e.response!.data is Map<String, dynamic>) {
        final data = e.response!.data as Map<String, dynamic>;
        final dynamic rawMsg = data['message'];
        if (rawMsg is List && rawMsg.isNotEmpty) {
          return NetworkFailure.serverError(rawMsg.map((e) => e.toString()).join('\n'));
        } else if (rawMsg is String && rawMsg.isNotEmpty) {
          return NetworkFailure.serverError(rawMsg);
        } else if (data['error'] != null) {
          return NetworkFailure.serverError(data['error'].toString());
        }
      }
      return const NetworkFailure.unknown("Unknown server error");
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const NetworkFailure.timeout();
    }

    return NetworkFailure.unknown(e.message ?? "Unknown error");
  }
}

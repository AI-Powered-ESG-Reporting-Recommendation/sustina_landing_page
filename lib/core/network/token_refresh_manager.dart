import 'dart:async';

import 'package:dio/dio.dart';
import 'package:suatina_web_project/core/constants/api_constants.dart';
import 'package:suatina_web_project/core/di/service_locator.dart';
import 'package:suatina_web_project/core/helpers/secure_storage_helper.dart';

class TokenRefreshManager {
  TokenRefreshManager(this.dio);

  final Dio dio;

  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  Future<String?> refreshToken() async {
    final storage = getIt<SecureStorageHelper>();

    final refreshToken = await storage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    if (_isRefreshing) {
      await _refreshCompleter?.future;
      return storage.getToken();
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<void>();

    try {
      final response = await dio.post(
        ApiConstants.refreshToken,
        data: {'refresh_token': refreshToken},
      );

      final responseData = response.data;

      if (responseData is! Map<String, dynamic>) {
        return null;
      }

      final data = responseData['data'];

      if (data is! Map<String, dynamic>) {
        return null;
      }

      final newAccessToken = data['access_token'];

      if (newAccessToken is! String || newAccessToken.isEmpty) {
        return null;
      }

      await storage.saveToken(newAccessToken);

      return newAccessToken;
    } catch (e) {
      return null;
    } finally {
      if (!(_refreshCompleter?.isCompleted ?? true)) {
        _refreshCompleter?.complete();
      }

      _refreshCompleter = null;
      _isRefreshing = false;
    }
  }
}

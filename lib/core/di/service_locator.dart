import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suatina_web_project/core/helpers/secure_storage_helper.dart';
import 'package:suatina_web_project/core/helpers/shared_pref_helper.dart';
import 'package:suatina_web_project/core/network/api_client.dart';
import 'package:suatina_web_project/core/network/api_handler.dart';
import 'package:suatina_web_project/core/network/dio_factory.dart';
import 'package:suatina_web_project/core/localization/locale_cubit.dart';
import 'package:suatina_web_project/core/network/network_manager.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> initServiceLocator() async {
  final sharedPrefs = await SharedPrefHelper.init();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<SecureStorageHelper>(
    () => SecureStorageHelper(getIt<FlutterSecureStorage>()),
  );

  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());

  getIt.registerLazySingleton<DioFactory>(() => DioFactory());

  final dio = await getIt<DioFactory>().createDio();
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));

  getIt.registerLazySingleton<ApiHandler>(() => ApiHandler());

  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  getIt.registerLazySingleton<LocaleCubit>(() => LocaleCubit());
}

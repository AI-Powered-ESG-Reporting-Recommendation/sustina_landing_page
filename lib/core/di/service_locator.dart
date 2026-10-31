import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sustina_app/core/helpers/secure_storage_helper.dart';
import 'package:sustina_app/core/helpers/shared_pref_helper.dart';
import 'package:sustina_app/core/network/api_client.dart';
import 'package:sustina_app/core/network/api_handler.dart';
import 'package:sustina_app/core/network/dio_factory.dart';
import 'package:sustina_app/core/network/network_manager.dart';
import 'package:sustina_app/features/auth/data/repos/forget_password_repo.dart';
import 'package:sustina_app/features/auth/data/repos/get_industries_repo.dart';
import 'package:sustina_app/features/auth/data/repos/get_sectors_repo.dart';
import 'package:sustina_app/features/auth/data/repos/get_sub_industries_repo.dart';
import 'package:sustina_app/features/auth/data/repos/login_repo.dart';
import 'package:sustina_app/features/auth/data/repos/register_repo.dart';
import 'package:sustina_app/features/auth/data/repos/reset_password_repo.dart';
import 'package:sustina_app/features/auth/data/repos/verify_otp_repo.dart';
import 'package:sustina_app/features/auth/presentation/logic/forget_password/forget_password_cubit.dart';
import 'package:sustina_app/features/auth/presentation/logic/industries/industries_cubit.dart';
import 'package:sustina_app/features/auth/presentation/logic/login/login_cubit.dart';
import 'package:sustina_app/features/auth/presentation/logic/register/register_cubit.dart';
import 'package:sustina_app/features/auth/presentation/logic/reset_password/reset_password_cubit.dart';
import 'package:sustina_app/features/auth/presentation/logic/sectors/sectors_cubit.dart';
import 'package:sustina_app/features/auth/presentation/logic/sub_industries/sub_industries_cubit.dart';
import 'package:sustina_app/features/auth/presentation/logic/verify_otp/verify_otp_cubit.dart';
import 'package:sustina_app/features/data/data/repos/data_categories_repo.dart';
import 'package:sustina_app/features/data/data/repos/data_items_repo.dart';
import 'package:sustina_app/features/data/presentation/logic/data_categories/data_categories_cubit.dart';
import 'package:sustina_app/features/data_category_detail/presentation/logic/data_items/data_items_cubit.dart';
import 'package:sustina_app/features/ocr/data/datasources/ocr_remote_data_source.dart';
import 'package:sustina_app/features/ocr/data/repos/ocr_repo.dart';
import 'package:sustina_app/features/ocr/presentation/logic/ocr_cubit.dart';
import 'package:sustina_app/features/report/data/repositories/report_repository.dart';
import 'package:sustina_app/features/report/presentation/logic/cubit/carbon_emissions_cubit.dart';
import 'package:sustina_app/features/report/presentation/logic/cubit/esg_report_cubit.dart';
import 'package:sustina_app/features/report/presentation/logic/cubit/report_categories_cubit.dart';
import 'package:sustina_app/features/tasks/data/repos/tasks_repository.dart';
import 'package:sustina_app/features/tasks/presentation/logic/tasks_cubit.dart';
import 'package:sustina_app/features/more/data/repos/suppliers_repository.dart';
import 'package:sustina_app/features/more/presentation/logic/suppliers_cubit.dart';

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

  getIt.registerLazySingleton<GetSectorsRepo>(
    () => GetSectorsRepo(
      apiClient: getIt<ApiClient>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );
  getIt.registerLazySingleton<GetIndustriesRepo>(
    () => GetIndustriesRepo(
      apiClient: getIt<ApiClient>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );

  getIt.registerLazySingleton<GetSubIndustriesRepo>(
    () => GetSubIndustriesRepo(
      apiClient: getIt<ApiClient>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );

  getIt.registerFactory(
    () => SectorsCubit(getSectorsRepo: getIt<GetSectorsRepo>()),
  );

  getIt.registerFactory(
    () => IndustriesCubit(getIndustriesRepo: getIt<GetIndustriesRepo>()),
  );

  getIt.registerFactory(
    () =>
        SubIndustriesCubit(getSubIndustriesRepo: getIt<GetSubIndustriesRepo>()),
  );

  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepo(
      apiClient: getIt<ApiClient>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(loginRepo: getIt<LoginRepo>()),
  );

  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(
      apiClient: getIt<ApiClient>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(registerRepo: getIt<RegisterRepo>()),
  );

  getIt.registerLazySingleton<ForgetPasswordRepo>(
    () => ForgetPasswordRepo(
      apiClient: getIt<ApiClient>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );

  getIt.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(getIt<ForgetPasswordRepo>()),
  );

  getIt.registerLazySingleton<DataCategoriesRepo>(
    () => DataCategoriesRepo(
      apiClient: getIt<ApiClient>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );

  getIt.registerFactory<DataCategoriesCubit>(
    () => DataCategoriesCubit(dataCategoriesRepo: getIt<DataCategoriesRepo>()),
  );

  getIt.registerLazySingleton<DataItemsRepo>(
    () => DataItemsRepo(
      apiClient: getIt<ApiClient>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );

  getIt.registerFactory<DataItemsCubit>(
    () => DataItemsCubit(dataItemsRepo: getIt<DataItemsRepo>()),
  );

  getIt.registerLazySingleton<ResetPasswordRepo>(
    () => ResetPasswordRepo(
      apiClient: getIt<ApiClient>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );
  getIt.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(resetPasswordRepo: getIt<ResetPasswordRepo>()),
  );

  getIt.registerLazySingleton<VerifyOtpRepo>(
    () => VerifyOtpRepo(
      apiClient: getIt<ApiClient>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );
  getIt.registerFactory<VerifyOtpCubit>(
    () => VerifyOtpCubit(verifyOtpRepo: getIt<VerifyOtpRepo>()),
  );

  // AI OCR
  getIt.registerLazySingleton<OcrRemoteDataSource>(
    () => OcrRemoteDataSourceImpl(getIt<Dio>()),
  );
  getIt.registerLazySingleton<OcrRepo>(
    () => OcrRepo(
      remoteDataSource: getIt<OcrRemoteDataSource>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );
  getIt.registerFactory<OcrCubit>(
    () => OcrCubit(getIt<OcrRepo>()),
  );

  // Report
  getIt.registerLazySingleton<ReportRepository>(
    () => ReportRepository(
      apiClient: getIt<ApiClient>(),
      apiHandler: getIt<ApiHandler>(),
    ),
  );

  getIt.registerFactory<ReportCategoriesCubit>(
    () => ReportCategoriesCubit(
      reportRepository: getIt<ReportRepository>(),
    ),
  );

  getIt.registerFactory<CarbonEmissionsCubit>(
    () => CarbonEmissionsCubit(
      reportRepository: getIt<ReportRepository>(),
    ),
  );

  getIt.registerFactory<EsgReportCubit>(
    () => EsgReportCubit(
      reportRepository: getIt<ReportRepository>(),
    ),
  );

  // Tasks
  getIt.registerLazySingleton<TasksRepository>(
    () => TasksRepository(),
  );
  getIt.registerFactory<TasksCubit>(
    () => TasksCubit(tasksRepository: getIt<TasksRepository>()),
  );

  // Suppliers (More / ESG Management)
  getIt.registerLazySingleton<SuppliersRepository>(
    () => SuppliersRepository(),
  );
  getIt.registerFactory<SuppliersCubit>(
    () => SuppliersCubit(suppliersRepository: getIt<SuppliersRepository>()),
  );
}


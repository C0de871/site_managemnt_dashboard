import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:site_managemnt_dashboard/features/engine_capacities/data/data%20sources/engine_capacities_remote_data_source.dart';
import 'package:site_managemnt_dashboard/features/engines/data/data%20sources/engine_remote_data_source.dart';
import 'package:site_managemnt_dashboard/features/generator_brand/data/data%20sources/generator_brands_remote_data_source.dart';
import 'package:site_managemnt_dashboard/features/reports/data/data_sources/reports_remote_data_source.dart';
import '../../../features/auth/data/data_sources/user_local_data_source.dart';
import '../../../features/auth/data/data_sources/user_remote_data_source.dart';
import '../../../features/auth/data/repository/repository_impl.dart';
import '../../../features/auth/domain/repository/repository.dart';
import '../../../features/auth/domain/usecases/login_user_use_case.dart';
import '../../../features/auth/domain/usecases/logout_use_use_case.dart';
import '../../../features/auth/domain/usecases/retreive_access_token_use_case.dart';
import '../../../features/auth/domain/usecases/retreive_user_use_case.dart';
import '../../../features/engine_brands/data/data sources/engine_brands_remote_data_source.dart';
import '../../../features/engine_brands/data/repository/engine_brands_repository_impl.dart';
import '../../../features/engine_brands/domain/repository/engine_brands_repository.dart';
import '../../../features/engine_brands/domain/usecases/add_engine_brand_usecase.dart';
import '../../../features/engine_brands/domain/usecases/delete_engines_brands_usecase.dart';
import '../../../features/engine_brands/domain/usecases/edit_engine_brand_usecase.dart';
import '../../../features/engine_brands/domain/usecases/get_engines_brands_usecase.dart';
import '../../../features/engine_capacities/data/repository/engine_capacities_repository_impl.dart';
import '../../../features/engine_capacities/domain/repository/engine_capacities_repository.dart';
import '../../../features/engine_capacities/domain/usecases/add_engine_capacity_usecase.dart';
import '../../../features/engine_capacities/domain/usecases/delete_engine_capacity_usecase.dart';
import '../../../features/engine_capacities/domain/usecases/edit_engine_capacity_usecase.dart';
import '../../../features/engine_capacities/domain/usecases/get_engine_capacities_usecase.dart';
import '../../../features/engines/data/repository/engine_repository_impl.dart';
import '../../../features/engines/domain/repository/engine_repository.dart';
import '../../../features/engines/domain/usecases/add_engine_usecase.dart';
import '../../../features/engines/domain/usecases/delete_engine_usecase.dart';
import '../../../features/engines/domain/usecases/edit_engine_usecase.dart';
import '../../../features/engines/domain/usecases/get_engines_usecase.dart';
import '../../../features/generator_brand/data/repository/generator_brands_repository_impl.dart';
import '../../../features/generator_brand/domain/repository/generator_brands_repository.dart';
import '../../../features/generator_brand/domain/usecases/add_generator_brand_usecase.dart';
import '../../../features/generator_brand/domain/usecases/delete_generator_brand_usecase.dart';
import '../../../features/generator_brand/domain/usecases/edit_generator_brand_usecase.dart';
import '../../../features/generator_brand/domain/usecases/get_generator_brands_usecase.dart';
import '../../../features/generators/data/data sources/generators_remote_data_source.dart';
import '../../../features/generators/data/repository/generators_repository_imple.dart';
import '../../../features/generators/domain/repository/generators_repository.dart';
import '../../../features/generators/domain/usecases/create_generators_usecase.dart';
import '../../../features/generators/domain/usecases/delete_generators_usecase.dart';
import '../../../features/generators/domain/usecases/edit_generators_usecase.dart';
import '../../../features/generators/domain/usecases/get_generators_usecase.dart';
import '../../../features/parts/data/data_sources/parts_remote_data_source.dart';
import '../../../features/parts/data/repository/parts_repository_impl.dart';
import '../../../features/parts/domain/repository/parts_repository.dart';
import '../../../features/parts/domain/usecases/add_part_usecase.dart';
import '../../../features/parts/domain/usecases/delete_part_usecase.dart';
import '../../../features/parts/domain/usecases/edit_part_usecase.dart';
import '../../../features/parts/domain/usecases/get_parts_usecase.dart';
import '../../../features/reports/data/repository/reports_repository_impl.dart';
import '../../../features/reports/domain/repository/reports_repository.dart';
import '../../../features/reports/domain/usecases/get_reports_usecase.dart';
import '../../../features/reports_details/data/data_sources/report_details_remote_data_source.dart';
import '../../../features/reports_details/data/repository/report_details_repository_impl.dart';
import '../../../features/reports_details/domain/repository/report_details_repository.dart';
import '../../../features/reports_details/domain/usecases/get_report_details_usecase.dart';
import '../../databases/api/api_consumer.dart';
import '../../databases/api/auth_interceptor.dart';
import '../../databases/api/dio_consumer.dart';
import '../../databases/cache/secure_storage_helper.dart';
import '../../databases/cache/shared_prefs_helper.dart';
import '../../databases/connection/network_info.dart';
import '../../theme/theme.dart';
// SITES FEATURE IMPORTS
import '../../../features/sites/data/data_sources/sites_remote_data_source.dart';
import '../../../features/sites/data/repository/sites_repository_impl.dart';
import '../../../features/sites/domain/repository/sites_repository.dart';
import '../../../features/sites/domain/usecases/add_site_usecase.dart';
import '../../../features/sites/domain/usecases/edit_site_usecase.dart';
import '../../../features/sites/domain/usecases/delete_site_usecase.dart';
import '../../../features/sites/domain/usecases/get_all_sites_usecase.dart';

final getIt = GetIt.instance; // Singleton instance of GetIt

void setupServicesLocator() {
  //!service:

  //! Core:
  getIt.registerLazySingleton<SharedPrefsHelper>(() {
    return SharedPrefsHelper()..init();
  });
  getIt.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper());
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt()));
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoConnectivity(getIt()),
  );
  getIt.registerLazySingleton<AppTheme>(() => AppTheme());

  //! Data Sources:
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<SitesRemoteDataSource>(
    () => SitesRemoteDataSource(api: getIt(), cacheHelper: getIt()),
  );

  getIt.registerLazySingleton<ReportsRemoteDataSource>(
    () => ReportsRemoteDataSource(api: getIt(), cacheHelper: getIt()),
  );

  getIt.registerLazySingleton<ReportDetailsRemoteDataSource>(
    () => ReportDetailsRemoteDataSource(api: getIt(), cacheHelper: getIt()),
  );

  getIt.registerLazySingleton<ReportsRemoteDataSource>(
    () => ReportsRemoteDataSource(api: getIt(), cacheHelper: getIt()),
  );

  getIt.registerLazySingleton<PartsRemoteDataSource>(
    () => PartsRemoteDataSource(api: getIt(), cacheHelper: getIt()),
  );

  getIt.registerLazySingleton<GeneratorsRemoteDataSource>(
    () => GeneratorsRemoteDataSource(api: getIt(), cacheHelper: getIt()),
  );

  getIt.registerLazySingleton<GeneratorBrandsRemoteDataSource>(
    () => GeneratorBrandsRemoteDataSource(api: getIt(), cacheHelper: getIt()),
  );

  getIt.registerLazySingleton<EngineRemoteDataSource>(
    () => EngineRemoteDataSource(api: getIt()),
  );

  getIt.registerLazySingleton<EngineBrandsRemoteDataSource>(
    () => EngineBrandsRemoteDataSource(api: getIt(), cacheHelper: getIt()),
  );

  getIt.registerLazySingleton<EngineCapacitiesRemoteDataSource>(
    () => EngineCapacitiesRemoteDataSource(api: getIt(), cacheHelper: getIt()),
  );

  //! local date soures:
  getIt.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSource(getIt<SecureStorageHelper>()),
  );

  //! Repository:
  getIt.registerLazySingleton<SitesRepository>(
    () => SitesRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
      localDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton<ReportDetailsRepository>(
    () => ReportDetailsRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton<ReportsRepository>(
    () =>
        ReportsRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  getIt.registerLazySingleton<PartsRepository>(
    () => PartsRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  getIt.registerLazySingleton<GeneratorsRepository>(
    () => GeneratorsRepositoryImple(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton<EngineRepository>(
    () => EngineRepositoryImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  getIt.registerLazySingleton<GeneratorBrandsRepository>(
    () => GeneratorBrandsRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton<EngineBrandsRepository>(
    () => EngineBrandsRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton<EngineCapacitiesRepository>(
    () => EngineCapacitiesRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  //! use cases:
  //! AUTH USE CASES
  getIt.registerLazySingleton<LoginUserUseCase>(
    () => LoginUserUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<RetreiveUserUseCase>(
    () => RetreiveUserUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<RetreiveAccessTokenUseCase>(
    () => RetreiveAccessTokenUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<LogoutUserUseCase>(
    () => LogoutUserUseCase(repository: getIt()),
  );

  //! SITES USE CASES
  getIt.registerLazySingleton<AddSiteUseCase>(
    () => AddSiteUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<EditSiteUseCase>(
    () => EditSiteUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<DeleteSiteUseCase>(
    () => DeleteSiteUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetAllSitesUseCase>(
    () => GetAllSitesUseCase(repository: getIt()),
  );

  //! ENGINES USE CASES
  getIt.registerLazySingleton<CreateEngineUseCase>(
    () => CreateEngineUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<EditEngineUseCase>(
    () => EditEngineUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<DeleteEnginesUseCase>(
    () => DeleteEnginesUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetEnginesUseCase>(
    () => GetEnginesUseCase(repository: getIt()),
  );

  //! GENERATORS USE CASES
  getIt.registerLazySingleton<CreateGeneratorUsecase>(
    () => CreateGeneratorUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<EditGeneratorUsecase>(
    () => EditGeneratorUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<DeleteGeneratorsUsecase>(
    () => DeleteGeneratorsUsecase(generator: getIt()),
  );
  getIt.registerLazySingleton<GetGeneratorsUseCase>(
    () => GetGeneratorsUseCase(repository: getIt()),
  );

  //! GENERATOR BRANDS USE CASES
  getIt.registerLazySingleton<AddGeneratorBrandUsecase>(
    () => AddGeneratorBrandUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<EditGeneratorBrandUsecase>(
    () => EditGeneratorBrandUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<DeleteGeneratorBrandsUsecase>(
    () => DeleteGeneratorBrandsUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetGeneratorBrandsUsecase>(
    () => GetGeneratorBrandsUsecase(repository: getIt()),
  );

  //! ENGINE CAPACITIES USE CASES
  getIt.registerLazySingleton<AddEngineCapacityUsecase>(
    () => AddEngineCapacityUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<EditEngineCapacityUsecase>(
    () => EditEngineCapacityUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<DeleteEngineCapacitiesUsecase>(
    () => DeleteEngineCapacitiesUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetEngineCapacitiesUsecase>(
    () => GetEngineCapacitiesUsecase(repository: getIt()),
  );

  //! Engine Brands USE CASES
  getIt.registerLazySingleton<AddEngineBrandUsecase>(
    () => AddEngineBrandUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<EditEngineBrandUsecase>(
    () => EditEngineBrandUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<DeleteEngineBrandsUsecase>(
    () => DeleteEngineBrandsUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetEngineBrandsUsecase>(
    () => GetEngineBrandsUsecase(repository: getIt()),
  );

  //! parts USE CASES
  getIt.registerLazySingleton<AddPartUsecase>(
    () => AddPartUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<EditPartUsecase>(
    () => EditPartUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<DeletePartsUsecase>(
    () => DeletePartsUsecase(repository: getIt()),
  );
  getIt.registerLazySingleton<GetPartsUsecase>(
    () => GetPartsUsecase(repository: getIt()),
  );

  //! reports USE CASES
  getIt.registerLazySingleton<GetReportsUsecase>(
    () => GetReportsUsecase(repository: getIt()),
  );

  //! report details USE CASES
  getIt.registerLazySingleton<GetReportDetailsUsecase>(
    () => GetReportDetailsUsecase(repository: getIt()),
  );

  //! Interceptors:
  getIt.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(retrieveAccessTokenUseCase: getIt()),
  );
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServicesLocator();
}

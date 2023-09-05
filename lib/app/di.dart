import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_source/local_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/alassame_api.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //------------------------------------------ categories ------------------------------------------------------
  instance.registerLazySingleton<AppCategoriesServiceClient>(
      () => AppCategoriesServiceClient(dio));
  // instance.registerLazySingleton<CategoriesRemoteDataSourceImpl>(() =>
  //     CategoriesRemoteDataSourceImpl(instance<AppCategoriesServiceClient>()));
  // instance.registerLazySingleton<CategoriesRepository>(
  //     () => CategoriesRepositoryImpl(instance(), instance(), instance()));
  // instance
  //     .registerFactory<CategoriesUseCase>(() => CategoriesUseCase(instance()));
  // instance.registerLazySingleton<CategoriesRemoteDataSource>(() =>
  //     CategoriesRemoteDataSourceImpl(instance<AppCategoriesServiceClient>()));
  //------------------------------------------ categories ------------------------------------------------------

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository

  // instance.registerLazySingleton<AuthRepository>(
  //     () => AuthRepositoryImpl(instance(), instance(), instance()));
  // instance.registerLazySingleton<HomeReposityory>(
  //     () => HomeRepositoryImpl(instance(), instance(), instance()));
  // instance.registerLazySingleton<AllMallsRepoistory>(
  //     () => AllMallsRepositoryImpl(instance(), instance(), instance()));
  // instance.registerLazySingleton<AllCompoundsRepoistory>(
  //     () => AllCompoundsRepositoryImpl(instance(), instance(), instance()));
  // instance.registerLazySingleton<AllCompaniesRepoistory>(
  //     () => AllCompaniesRepositoryImpl(instance(), instance(), instance()));
  //instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  // instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));

  // instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  // instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
  // instance
  //     .registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
  // instance.registerFactory<ImagePicker>(() => ImagePicker());
  // instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  // instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
  // instance
  //     .registerFactory<AllMallsViewModel>(() => AllMallsViewModel(instance()));
  // instance.registerFactory<AllMallsUseCase>(() => AllMallsUseCase(instance()));
  // instance.registerFactory<AllCompoundsViewModel>(
  //     () => AllCompoundsViewModel(instance()));
  // instance.registerFactory<AllCompoundsUseCase>(
  //     () => AllCompoundsUseCase(instance()));
  // instance.registerFactory<AllCompaniesViewModel>(
  //     () => AllCompaniesViewModel(instance()));
  // instance.registerFactory<AllCompaniesUseCase>(
  //     () => AllCompaniesUseCase(instance()));
}

initLoginModule() {
  // if (!GetIt.I.isRegistered<LoginUseCase>()) {
  //   instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
  //   instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  // }
}

initForgotPasswordModule() {
  // if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
  //   instance.registerFactory<ForgotPasswordUseCase>(
  //       () => ForgotPasswordUseCase(instance()));
  //   // instance.registerFactory<ForgotPasswordViewModel>(
  //   //     () => ForgotPasswordViewModel(instance()));
  // }
}

initRegisterModule() {
  // if (!GetIt.I.isRegistered<RegisterUseCase>()) {
  //   instance
  //       .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
  //   instance.registerFactory<RegisterViewModel>(
  //       () => RegisterViewModel(instance()));
  //   instance.registerFactory<ImagePicker>(() => ImagePicker());
  // }
}

initHomeModule() {
  //if (!GetIt.I.isRegistered<HomeUseCase>()) {
  //   instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
  //   instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  //}
}

initStoreDetailsModule() {
  // if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
  //   instance.registerFactory<StoreDetailsUseCase>(
  //       () => StoreDetailsUseCase(instance()));
  // }
}

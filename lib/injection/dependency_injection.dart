import 'package:flutter_application_1/features/Demo/data/repositories/home_repo_impl.dart';
import 'package:flutter_application_1/features/Demo/data/services/api_services.dart';
import 'package:flutter_application_1/features/Demo/data/services/database_helper.dart';
import 'package:flutter_application_1/features/Demo/domain/repositories/homerepo.dart';
import 'package:flutter_application_1/features/Demo/presentation/bloc/auth_bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Register ApiServices
  getIt.registerLazySingleton(() => ApiServices());

  // Register dbhelper
  getIt.registerLazySingleton(() => DatabaseHelper());

  // Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(apiServices: getIt<ApiServices>()),
  );

  // Bloc
  getIt.registerFactory(() => HomeBloc(getIt<HomeRepository>()));

}

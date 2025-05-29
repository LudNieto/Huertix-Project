import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huertix_project/config/provider/auth_provider.dart';
import 'package:huertix_project/features/auth/data/auth_repository_impl.dart';
import 'package:huertix_project/features/auth/data/firebase_auth_datasource.dart';
import 'package:huertix_project/features/auth/domain/auth_repository.dart';
import 'package:huertix_project/features/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:huertix_project/features/auth/domain/usecases/login_usecase.dart';
import 'package:huertix_project/features/auth/domain/usecases/register_usecase.dart';
import 'package:huertix_project/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:huertix_project/features/plots/data/plot_repository_impl.dart';
import 'package:huertix_project/features/plots/model/repositories/plot_repository.dart';
import 'package:huertix_project/features/plots/model/usecases/create_plot_usecase.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // --- Features - Auth ---
  sl.registerFactory(
    () => AuthProvider(
      loginUseCase: sl(),
      registerUseCase: sl(),
      getUserProfileUseCase: sl(),
      signOutUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<FirebaseAuthDataSource>(() => FirebaseAuthDataSourceImpl(sl(), sl()));

  sl.registerLazySingleton(() => CreatePlotUseCase(sl()));

  sl.registerLazySingleton<PlotRepository>(
      () => PlotRepositoryImpl(firestore: sl()));
  
  // --- External ---
  sl.registerLazySingleton(() => fb_auth.FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
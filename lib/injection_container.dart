import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huertix_project/features/auth/presentation/providers/auth_provider.dart';
import 'package:huertix_project/features/auth/data/auth_repository_impl.dart';
import 'package:huertix_project/features/auth/data/firebase_auth_datasource.dart';
import 'package:huertix_project/features/auth/domain/auth_repository.dart';
import 'package:huertix_project/features/auth/domain/usecase/get_user_profile_usecase.dart';
import 'package:huertix_project/features/auth/domain/usecase/login_usecase.dart';
import 'package:huertix_project/features/auth/domain/usecase/register_usecase.dart';
import 'package:huertix_project/features/auth/domain/usecase/sign_out_usecase.dart';


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

  // --- External ---
  sl.registerLazySingleton(() => fb_auth.FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
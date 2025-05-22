import 'package:dartz/dartz.dart';
import 'package:huertix_project/features/auth/data/firebase_auth_datasource.dart';
import 'package:huertix_project/features/auth/domain/auth_repository.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
import 'package:huertix_project/features/core/error.dart';
import 'package:huertix_project/features/core/exception.dart';


class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String residentialZone,
    required List<String> availabilityDays,
    String? previousExperience,
  }) async {
    try {
      final userModel = await remoteDataSource.registerUserInFirestore(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        residentialZone: residentialZone,
        availabilityDays: availabilityDays,
        previousExperience: previousExperience,
      );
      return Right(userModel);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
        return Left(ServerFailure("Error inesperado en el repositorio de registro: ${e.toString()}"));
    }
  }


  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final firebaseUser = await remoteDataSource.signInWithEmailAndPasswordInFirebaseAuth(
        email: email,
        password: password,
      );
      final userModel = await remoteDataSource.getUserProfileFromFirestore(firebaseUser.uid);
      return Right(userModel);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
        return Left(ServerFailure("Error inesperado en el repositorio de login: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserProfile(String uid) async {
    try {
      final userModel = await remoteDataSource.getUserProfileFromFirestore(uid);
      return Right(userModel);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure("Error inesperado al obtener perfil en repositorio: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOutFromFirebaseAuth();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    }
  }
}
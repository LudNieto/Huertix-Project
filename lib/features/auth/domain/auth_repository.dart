import 'package:dartz/dartz.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
import 'package:huertix_project/features/core/error.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String residentialZone,
    required List<String> availabilityDays,
    String? previousExperience,
  });

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserEntity>> getUserProfile(String uid);
}
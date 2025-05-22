import 'package:dartz/dartz.dart';
import 'package:huertix_project/features/auth/domain/auth_repository.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
import 'package:huertix_project/features/core/error.dart';
import 'package:huertix_project/features/core/usecase.dart';

class RegisterUseCase implements UseCase<UserEntity, RegisterUserParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterUserParams params) async {
    return await repository.registerUser(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
      phone: params.phone,
      residentialZone: params.residentialZone,
      availabilityDays: params.availabilityDays,
      previousExperience: params.previousExperience,
    );
  }
}
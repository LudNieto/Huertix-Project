import 'package:dartz/dartz.dart';
import 'package:huertix_project/features/auth/domain/auth_repository.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
import 'package:huertix_project/features/core/error.dart';
import 'package:huertix_project/features/core/usecase.dart';


class GetUserProfileUseCase implements UseCase<UserEntity, UserProfileParams> {
  final AuthRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UserProfileParams params) async {
    return await repository.getUserProfile(params.uid);
  }
}
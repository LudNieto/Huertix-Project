import 'package:dartz/dartz.dart';
import 'package:huertix_project/features/auth/domain/auth_repository.dart';
import 'package:huertix_project/features/core/error.dart';
import 'package:huertix_project/features/core/usecase.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
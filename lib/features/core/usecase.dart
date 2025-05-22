import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:huertix_project/features/core/error.dart';


abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthParams extends Equatable {
  final String email;
  final String password;

  const AuthParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterUserParams extends Equatable {
  final String email;
  final String password;
  final String fullName;
  final String phone;
  final String residentialZone;
  final List<String> availabilityDays;
  final String? previousExperience;

  const RegisterUserParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
    required this.residentialZone,
    required this.availabilityDays,
    this.previousExperience,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        fullName,
        phone,
        residentialZone,
        availabilityDays,
        previousExperience,
      ];
}

class UserProfileParams extends Equatable {
  final String uid;
  const UserProfileParams({required this.uid});
  @override
  List<Object> get props => [uid];
}
import 'package:equatable/equatable.dart';

enum UserRole { admin, volunteer, unknown }

String userRoleToString(UserRole role) {
  switch (role) {
    case UserRole.admin: return 'admin';
    case UserRole.volunteer: return 'volunteer';
    default: return 'unknown';
  }
}

UserRole stringToUserRole(String? roleString) {
  switch (roleString?.toLowerCase()) {
    case 'admin': return UserRole.admin;
    case 'volunteer': return UserRole.volunteer;
    default: return UserRole.unknown;
  }
}

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String fullName;
  final String phone;
  final String residentialZone;
  final List<String> availabilityDays;
  final String? previousExperience;
  final UserRole role;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.residentialZone,
    required this.availabilityDays,
    this.previousExperience,
    required this.role,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        fullName,
        phone,
        residentialZone,
        availabilityDays,
        previousExperience,
        role,
      ];
}
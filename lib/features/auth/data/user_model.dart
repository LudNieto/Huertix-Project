import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    required super.phone,
    required super.residentialZone,
    required super.availabilityDays,
    super.previousExperience,
    required super.role,
  });

  // Factory para crear UserModel desde un DocumentSnapshot de Firestore
  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw Exception("Documento de usuario no contiene datos (UID: ${doc.id})");
    }
    return UserModel(
      uid: doc.id,
      email: data['email'] as String? ?? '',
      fullName: data['fullName'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      residentialZone: data['residentialZone'] as String? ?? '',
      availabilityDays: List<String>.from(data['availabilityDays'] as List? ?? []),
      previousExperience: data['previousExperience'] as String?,
      role: stringToUserRole(data['role'] as String?),
    );
  }

  // Método para convertir UserModel a un Map para guardar en Firestore
  Map<String, dynamic> toFirestoreMap() {
    return {
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'residentialZone': residentialZone,
      'availabilityDays': availabilityDays,
      'previousExperience': previousExperience,
      'role': userRoleToString(role),
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
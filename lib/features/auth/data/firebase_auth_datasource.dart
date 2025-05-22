import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huertix_project/features/auth/data/user_model.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
import 'package:huertix_project/features/core/exception.dart';

abstract class FirebaseAuthDataSource {
  Future<UserModel> registerUserInFirestore({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String residentialZone,
    required List<String> availabilityDays,
    String? previousExperience,
  });

  Future<fb_auth.User> signInWithEmailAndPasswordInFirebaseAuth({
    required String email,
    required String password,
  });

  Future<void> signOutFromFirebaseAuth();

  Future<UserModel> getUserProfileFromFirestore(String uid);
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final fb_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseAuthDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  Future<UserModel> registerUserInFirestore({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String residentialZone,
    required List<String> availabilityDays,
    String? previousExperience,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw AuthException(
          "Error creando usuario en Firebase Auth: Usuario nulo.",
        );
      }

      final userToSaveInFirestore = UserModel(
        uid: firebaseUser.uid,
        email: email,
        fullName: fullName,
        phone: phone,
        residentialZone: residentialZone,
        availabilityDays: availabilityDays,
        previousExperience: previousExperience,
        role: UserRole.volunteer, 
      );

      await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(userToSaveInFirestore.toFirestoreMap());

      return userToSaveInFirestore;
    } on fb_auth.FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException("El correo electrónico ya está en uso.");
      }
      throw AuthException(
        e.message ?? "Error de Firebase Auth durante el registro.",
      );
    } catch (e) {
      throw AuthException(
        "Error inesperado durante el registro y guardado en Firestore: ${e.toString()}",
      );
    }
  }

  @override
  Future<fb_auth.User> signInWithEmailAndPasswordInFirebaseAuth({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw AuthException(
          "Error iniciando sesión: Usuario de Firebase nulo.",
        );
      }
      return userCredential.user!;
    } on fb_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        throw AuthException("Correo electrónico o contraseña incorrectos.");
      }
      throw AuthException(
        e.message ?? "Error de Firebase Auth al iniciar sesión.",
      );
    } catch (e) {
      throw AuthException(
        "Error inesperado al iniciar sesión: ${e.toString()}",
      );
    }
  }

  @override
  Future<UserModel> getUserProfileFromFirestore(String uid) async {
    try {
      final docSnapshot = await _firestore.collection('users').doc(uid).get();

      if (!docSnapshot.exists) {
        throw AuthException(
          "Perfil de usuario no encontrado en Firestore (UID: $uid).",
        );
      }
      return UserModel.fromFirestore(docSnapshot);
    } on FirebaseException catch (e) {
      throw AuthException(
        "Error de Firestore al obtener perfil (UID: $uid): ${e.message}",
      );
    } catch (e) {
      throw AuthException(
        "Error inesperado al obtener perfil de Firestore (UID: $uid): ${e.toString()}",
      );
    }
  }

  @override
  Future<void> signOutFromFirebaseAuth() async {
    try {
      await _firebaseAuth.signOut();
    } on fb_auth.FirebaseAuthException catch (e) {
      throw AuthException(
        e.message ?? "Error al cerrar sesión en Firebase Auth",
      );
    }
  }
}

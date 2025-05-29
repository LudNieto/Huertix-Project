import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huertix_project/features/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:huertix_project/features/auth/domain/usecases/login_usecase.dart';
import 'package:huertix_project/features/auth/domain/usecases/register_usecase.dart';
import 'package:huertix_project/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
import 'package:huertix_project/features/core/error.dart';
import 'package:huertix_project/features/core/usecase.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthProvider extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;
  final SignOutUseCase _signOutUseCase;

  AuthProvider({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required GetUserProfileUseCase getUserProfileUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _getUserProfileUseCase = getUserProfileUseCase,
        _signOutUseCase = signOutUseCase;

  AuthStatus _status = AuthStatus.initial;
  UserEntity? _user;
  String? _errorMessage;
  int _currentStep = 0;

  int get currentStep => _currentStep;
  AuthStatus get status => _status;
  UserEntity? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == AuthStatus.loading;

  Future<void> checkFirebaseSession() async {
    _status = AuthStatus.loading;
    notifyListeners();
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      fetchUserProfile(firebaseUser.uid);
    } else {
      _status = AuthStatus.unauthenticated;
      _user = null;
    }
    notifyListeners();
  }

  Future<void> loginUser(String email, String password) async {
    _updateStatus(AuthStatus.loading);
    final failureOrUserEntity = await _loginUseCase(AuthParams(email: email, password: password));
    failureOrUserEntity.fold(
      (failure) => _handleFailure(failure),
      (userEntity) => _handleSuccess(userEntity),
    );
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String residentialZone,
    required List<String> availabilityDays,
    String? previousExperience,
  }) async {
    _updateStatus(AuthStatus.loading);
    final params = RegisterUserParams(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
      residentialZone: residentialZone,
      availabilityDays: availabilityDays,
      previousExperience: previousExperience,
    );
    final failureOrUserEntity = await _registerUseCase(params);
    failureOrUserEntity.fold(
      (failure) => _handleFailure(failure),
      (userEntity) => _handleSuccess(userEntity),
    );
  }

  Future<void> fetchUserProfile(String uid) async {
    final failureOrUserEntity = await _getUserProfileUseCase(UserProfileParams(uid: uid));
    failureOrUserEntity.fold(
      (failure) {
        _handleFailure(failure, markAsUnauthenticated: true);
      },
      (userEntity) => _handleSuccess(userEntity),
    );
  }

  Future<void> logoutUser() async {
    _updateStatus(AuthStatus.loading);
    final failureOrSuccess = await _signOutUseCase(NoParams());
    failureOrSuccess.fold(
      (failure) => _handleFailure(failure),
      (_) => _updateStatus(AuthStatus.unauthenticated, userEntity: null, message: null),
    );
  }

  void _updateStatus(AuthStatus newStatus, {String? message, UserEntity? userEntity}) {
    _status = newStatus;
    _errorMessage = message;
    if (userEntity != null) {
      _user = userEntity;
    } else if (newStatus == AuthStatus.unauthenticated) {
      _user = null;
    }
    notifyListeners();
  }

  void _handleSuccess(UserEntity userEntity) {
    _user = userEntity;
    _errorMessage = null;
    _status = AuthStatus.authenticated;
    notifyListeners();
  }

  void _handleFailure(Failure failure, {bool markAsUnauthenticated = false}) {
    _errorMessage = failure.message;
    if (markAsUnauthenticated) {
      _user = null;
      _status = AuthStatus.unauthenticated;
    } else {
      _status = AuthStatus.failure;
    }
    notifyListeners();
  }

  void resetError() {
    if (_errorMessage != null || _status == AuthStatus.failure) {
      _errorMessage = null;
      if (_status == AuthStatus.failure) {
          _status = _user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
      }
      notifyListeners();
    }
  }

  void nextStep() {
    _currentStep++;
    notifyListeners();
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void goToStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void resetStepper() {
    _currentStep = 0;
    notifyListeners();
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/data/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;

  AuthProvider({
    AuthRepository? repository,
  }) : _repository = repository ?? AuthRepository();

  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Firebase Auth State
  Stream<User?> get authStateChanges =>
      _repository.authStateChanges;

  // 1. Sign Up
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _repository.signUp(
        name: name,
        email: email,
        password: password,
      );

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 2. Sign In
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _repository.signIn(
        email: email,
        password: password,
      );

      return _user != null;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 3. Current User Profile
  Future<void> loadCurrentUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _repository.getCurrentUserProfile();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 4. Forgot Password
  Future<bool> sendPasswordReset(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.sendPasswordReset(email);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 5. Sign Out
  Future<void> signOut() async {
    await _repository.signOut();

    _user = null;
    notifyListeners();
  }

  // Error clear karna
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
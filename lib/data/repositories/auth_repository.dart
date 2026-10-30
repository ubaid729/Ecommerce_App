import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/features/auth/models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class AuthRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;

  // Constructor Dependency Injection
  AuthRepository({
    AuthService? authService,
    FirestoreService? firestoreService,
  })  : _authService = authService ?? AuthService(),
        _firestoreService = firestoreService ?? FirestoreService();

  // Auth State
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  // Current Firebase User
  User? get currentFirebaseUser => _authService.currentUser;

  // 1. Sign Up
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Step 1: Firebase Authentication mein account create
      final UserCredential credential =
          await _authService.signUpWithEmailPassword(
        email: email,
        password: password,
      );

      // Step 2: Firebase Auth se UID lena
      final String uid = credential.user!.uid;

      // Step 3: UserModel banana
      final UserModel newUser = UserModel(
        uid: uid,
        email: email,
        name: name,
        createdAt: DateTime.now(),
      );

      // Step 4: Firestore mein user profile save
      await _firestoreService.saveUser(newUser);

      return newUser;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw 'Account creation error.';
    }
  }

  // 2. Sign In
  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Step 1: Firebase Auth mein login
      final UserCredential credential =
          await _authService.signInWithEmailPassword(
        email: email,
        password: password,
      );

      // Step 2: UID lena
      final String uid = credential.user!.uid;

      // Step 3: Firestore se user profile lana
      final UserModel? userModel =
          await _firestoreService.getUser(uid);

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw 'Login error try again.';
    }
  }

  // 3. Current User Profile
  Future<UserModel?> getCurrentUserProfile() async {
    final User? firebaseUser = _authService.currentUser;

    if (firebaseUser != null) {
      return await _firestoreService.getUser(firebaseUser.uid);
    }

    return null;
  }

  // 4. Forgot Password
  Future<void> sendPasswordReset(String email) async {
    try {
      await _authService.sendPasswordReset(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw 'Reset link send issue.';
    }
  }

  // 5. Sign Out
  Future<void> signOut() async {
    await _authService.signOut();
  }

  // Firebase Errors ko simple message mein convert karna
  String _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'this email is not registered.';

      case 'wrong-password':
      case 'invalid-credential':
        return 'Email or password wrong.';

      case 'email-already-in-use':
        return 'this email already has account.';

      case 'invalid-email':
        return ' Email not exist';

      case 'weak-password':
        return 'Password is minimum 6 characters .';

      case 'network-request-failed':
        return 'check your internet connection .';

      case 'too-many-requests':
        return 'try after sometimes';

      default:
        return e.message ?? 'Authentication error .';
    }
  }
}
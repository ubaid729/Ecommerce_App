import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
  // 1. Email aur Password se Sign Up (New Account)
  Future<UserCredential> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }
  // 2. Email aur Password se Sign In
  Future<UserCredential> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }
  // 3. Forgot Password (Reset Link Send)
  Future<void> sendPasswordReset({required String email}) async {
    await _auth.sendPasswordResetEmail(
      email: email.trim(),
    );
  }
  // 4. Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
  
}
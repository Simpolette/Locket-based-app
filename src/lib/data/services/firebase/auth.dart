import 'package:firebase_auth/firebase_auth.dart';
import 'package:src/data/services/model/login_request/login_request.dart';
import 'package:src/utils/result.dart';

class AuthService {
  /// Cho phép chích (inject) một FirebaseAuth khác khi cần test.
  AuthService({FirebaseAuth? firebaseAuth})
    : _auth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  // Sign in with email and password
  Future<Result<User?>> signInWithEmailAndPassword(
    LoginRequest loginRequest,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: loginRequest.email,
        password: loginRequest.password,
      );
      return Result.ok(userCredential.user);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  // Sign out
  Future<Result<void>> signOut() async {
    try {
      await _auth.signOut();
      return const Result.ok(null);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
  // Register with email and password

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authChanges => _auth.authStateChanges();
  bool get isSignedIn => _auth.currentUser != null;
}

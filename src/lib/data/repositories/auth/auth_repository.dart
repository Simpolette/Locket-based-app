import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:src/data/services/model/login_request/login_request.dart';
import 'package:src/data/services/firebase/auth.dart';
import 'package:src/utils/result.dart';

abstract class AuthRepository {
  // SignIn
  Future<Result<void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  // SignOut
  Future<Result<void>> signOut();
}

// Impl "ôm" state: current user + stream
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthService authService})
    : _service = authService,
      // khởi tạo state ngay lập tức
      currentUser = authService.currentUser,
      authStateChanges = authService.authChanges {
    // luôn theo dõi để đồng bộ state
    _sub = authStateChanges.listen((u) {
      currentUser = u;
    });
  }

  final AuthService _service;

  User? currentUser;
  final Stream<User?> authStateChanges;

  StreamSubscription<User?>? _sub;

  @override
  Future<Result<void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final res = await _service.signInWithEmailAndPassword(
      LoginRequest(email: email, password: password),
    );

    // Handle Result theo kiểu Ok/Error
    switch (res) {
      case Ok<User?>():
        // currentUser sẽ được stream cập nhật; không cần tự gán nữa
        return const Result.ok(null);
      case Error<User?>(error: final e):
        return Result.error(e);
    }
  }

  @override
  Future<Result<void>> signOut() async {
    final res = await _service.signOut();
    switch (res) {
      case Ok<void>():
        // Eager update (không bắt buộc): stream cũng sẽ set null ngay sau đó
        return const Result.ok(null);

      case Error<void>(error: final e):
        return Result.error(e);
    }
  }

  // tiện: helper nếu bạn cần kiểm tra nhanh
  bool get isSignedIn => currentUser != null;

  void dispose() {
    _sub?.cancel();
  }
}

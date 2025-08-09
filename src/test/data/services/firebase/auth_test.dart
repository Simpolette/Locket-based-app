import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:src/data/services/firebase/auth.dart';
import 'package:src/data/services/model/login_request/login_request.dart';
import 'package:src/utils/result.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

/// ------------------
/// Mock classes
/// ------------------
///
class MockAuthService extends Mock implements AuthService {}

void main() {
  late AuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });

  test('should return user from signInWithEmailAndPassword', () async {
    final mockUser = MockUser(
      isAnonymous: false,
      email: 'example@gmail.com',
      displayName: 'test',
      phoneNumber: '0800 I CAN FIX IT',
      photoURL: 'http://photos.url/bobbie.jpg',
      refreshToken: 'some_long_token',
    );
    final loginRequest = LoginRequest(
      email: "example@gmail.com",
      password: "example",
    );
    when(
      () => mockAuthService.signInWithEmailAndPassword(loginRequest),
    ).thenAnswer((_) async => Result.ok(mockUser));

    final result = await mockAuthService.signInWithEmailAndPassword(
      loginRequest,
    );

    expect(result, isA<Ok<User?>>());

    switch (result) {
      // nhánh Ok
      case Ok(value: final user):
        // kiểm tra email
        expect(user?.email, equals(loginRequest.email));

        // check user
        expect(user, mockUser);

      // nhánh Error => fail test
      case Error(error: final e):
        fail('Expected Ok, got Error: $e');
    }
  });
}

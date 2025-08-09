import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:src/data/services/model/login_request/login_request.dart';
import 'package:src/utils/result.dart';
import 'package:src/data/services/firebase/auth.dart';
import 'package:src/data/repositories/auth/auth_repository.dart';

// ---- Mocks ----
class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockService;
  late AuthRepositoryImpl repo;

  setUp(() {
    mockService = MockAuthService();
    // Mock authChanges để trả về một Stream<User?>
    when(() => mockService.authChanges).thenAnswer((_) => Stream.value(null));
    repo = AuthRepositoryImpl(authService: mockService);
  });

  test(
    'signIn success → returns Ok<void> & updates currentUser from stream',
    () async {
      // Arrange
      final mockUser = MockUser(
        isAnonymous: false,
        email: 'example@gmail.com',
        displayName: 'test',
        phoneNumber: '0800 I CAN FIX IT',
        photoURL: 'http://photos.url/bobbie.jpg',
        refreshToken: 'some_long_token',
      );
      final loginRequest = LoginRequest(
        email: 'example@gmail.com',
        password: 'example',
      );

      // Mock hành vi signInWithEmailAndPassword trên mockService
      when(
        () => mockService.signInWithEmailAndPassword(loginRequest),
      ).thenAnswer((_) async => Result.ok(mockUser));

      // Mock stream để cập nhật currentUser
      when(
        () => mockService.authChanges,
      ).thenAnswer((_) => Stream.fromIterable([null, mockUser]));

      when(
        () => mockService.signInWithEmailAndPassword(loginRequest),
      ).thenAnswer((_) async => Result.ok(mockUser));

      // Act
      final res = await repo.signInWithEmailAndPassword(
        email: loginRequest.email,
        password: loginRequest.password,
      );

      // Assert
      expect(res, isA<Ok<void>>());

      // Verify rằng signInWithEmailAndPassword được gọi đúng
      verify(
        () => mockService.signInWithEmailAndPassword(loginRequest),
      ).called(1);
    },
  );

  tearDown(() {
    repo.dispose(); // Gọi dispose để hủy StreamSubscription
  });
}

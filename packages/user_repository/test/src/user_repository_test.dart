// ignore_for_file: prefer_const_constructors
import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';

class MockFirebaseAuthenticationClient extends Mock
    implements FirebaseAuthenticationClient {}

void main() {
  group('UserRepository', () {
    late FirebaseAuthenticationClient firebaseAuthenticationClient;

    setUp(() {
      firebaseAuthenticationClient = MockFirebaseAuthenticationClient();
    });
    test('can be instantiated', () {
      expect(
        UserRepository(authenticationClient: firebaseAuthenticationClient),
        isNotNull,
      );
    });
  });
}

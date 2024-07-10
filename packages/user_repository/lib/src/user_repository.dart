// ignore_for_file: public_member_api_docs

import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:user_repository/user_repository.dart';

/// {@template user_repository}
/// User repository.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  const UserRepository({
    required FirebaseAuthenticationClient authenticationClient,
  }) : _authenticationClient = authenticationClient;

  final FirebaseAuthenticationClient _authenticationClient;

  Stream<User> get user => _authenticationClient.user
      .map(User.fromAuthenticationUser)
      .asBroadcastStream();

  Stream<List<User>> get users => _authenticationClient.users
      .map((users) => users.map(User.fromJson).toList());

  Stream<bool> canAcceptCalls() => _authenticationClient.canAcceptCalls();

  Future<void> changeAcceptCalls({
    required bool acceptCalls,
  }) async {
    try {
      await _authenticationClient.changeAcceptCalls(acceptCalls: acceptCalls);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ChangeCanAcceptCallsFailure(error), stackTrace);
    }
  }

  Future<void> logInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationClient.logInWithPassword(
        email: email,
        password: password,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithPasswordFailure(error), stackTrace);
    }
  }

  Future<void> signUpWithPassword({
    required String password,
    required String email,
    required String name,
  }) async {
    try {
      await _authenticationClient.signUpWithPassword(
        email: email,
        password: password,
        name: name,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SignUpWithPasswordFailure(error), stackTrace);
    }
  }

  Future<void> logOut() async {
    try {
      await _authenticationClient.logOut();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }
}

// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart' as firebase_firestore;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_authentication_client/src/models/authentication_user.dart';

/// {@template authentication_exception}
/// Exceptions from the authentication client.
/// {@endtemplate}
abstract class AuthenticationException implements Exception {
  /// {@macro authentication_exception}
  const AuthenticationException(this.error);

  /// The error which was caught.
  final Object error;

  @override
  String toString() => 'Authentication exception error: $error';
}

/// {@template log_out_failure}
/// Thrown during the logout process if a failure occurs.
/// {@endtemplate}
class LogOutFailure extends AuthenticationException {
  /// {@macro log_out_failure}
  const LogOutFailure(super.error);
}

/// {@template log_in_with_password_failure}
/// Thrown during the sign in with password process if a failure occurs.
/// {@endtemplate}
class LogInWithPasswordFailure extends AuthenticationException {
  /// {@macro log_in_with_password_failure}
  const LogInWithPasswordFailure(super.error);
}

/// {@template sign_up_with_password_failure}
/// Thrown during the sign up with password process if a failure occurs.
/// {@endtemplate}
class SignUpWithPasswordFailure extends AuthenticationException {
  /// {@macro sign_up_with_password_failure}
  const SignUpWithPasswordFailure(super.error);
}

/// {@template fetch_can_accept_calls_failure}
/// Thrown during the fetch can accept calls process if a failure occurs.
/// {@endtemplate}
class FetchCanAcceptCallsFailure extends AuthenticationException {
  /// {@macro fetch_can_accept_calls_failure}
  const FetchCanAcceptCallsFailure(super.error);
}

/// {@template fetch_can_accept_calls_canceled}
/// Thrown during the fetch can accept calls process if a cancel occurs.
/// {@endtemplate}
class FetchCanAcceptCallsCanceled extends AuthenticationException {
  /// {@macro fetch_can_accept_calls_canceled}
  const FetchCanAcceptCallsCanceled(super.error);
}

/// {@template change_can_accept_calls_failure}
/// Thrown during the change can accept calls process if a failure occurs.
/// {@endtemplate}
class ChangeCanAcceptCallsFailure extends AuthenticationException {
  /// {@macro change_can_accept_calls_failure}
  const ChangeCanAcceptCallsFailure(super.error);
}

/// {@template change_can_accept_calls_canceled}
/// Thrown during the change can accept calls process if a cancel occurs.
/// {@endtemplate}
class ChangeCanAcceptCallsCanceled extends AuthenticationException {
  /// {@macro change_can_accept_calls_canceled}
  const ChangeCanAcceptCallsCanceled(super.error);
}

/// {@template firebase_authentication_client}
/// Firebase Auethentication Client.
/// {@endtemplate}
class FirebaseAuthenticationClient {
  /// {@macro firebase_authentication_client}
  FirebaseAuthenticationClient({
    firebase_auth.FirebaseAuth? firebaseAuth,
    firebase_firestore.FirebaseFirestore? firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFirestore =
            firebaseFirestore ?? firebase_firestore.FirebaseFirestore.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final firebase_firestore.FirebaseFirestore _firebaseFirestore;

  Stream<AuthenticationUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AuthenticationUser.anonymous
          : firebaseUser.toUser;
    });
  }

  Stream<List<Map<String, dynamic>>> get users => _firebaseFirestore
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => e.data()).toList());

  Stream<bool> canAcceptCalls() {
    return _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((snapshots) => snapshots.data()!['accept_calls'] as bool);
  }

  Future<void> changeAcceptCalls({
    required bool acceptCalls,
  }) async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) {
        throw const FetchCanAcceptCallsCanceled('User is not logged in');
      }
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .update({'accept_calls': acceptCalls});
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ChangeCanAcceptCallsFailure(error), stackTrace);
    }
  }

  Future<void> logInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
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
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        await user.updateProfile(displayName: name);

        final userDocRef = _firebaseFirestore.collection('users').doc(user.uid);
        final userDoc = await userDocRef.get();
        if (userDoc.exists) return;
        await userDocRef.set(
          {
            'id': user.uid,
            'name': name,
            'email': email,
            'accept_calls': true,
          },
        );
      }
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SignUpWithPasswordFailure(error), stackTrace);
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }
}

extension on firebase_auth.User {
  AuthenticationUser get toUser {
    return AuthenticationUser(
      id: uid,
      email: email ?? '',
      name: displayName ?? '',
    );
  }
}

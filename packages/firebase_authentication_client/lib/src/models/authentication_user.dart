// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// {@template authentication_user}
/// User model
///
/// [AuthenticationUser.anonymous] represents an unauthenticated user.
/// {@endtemplate}
class AuthenticationUser extends Equatable {
  /// {@macro authentication_user}
  const AuthenticationUser({
    required this.id,
    required this.email,
    required this.name,
  });

  /// The current user's email address.
  final String email;

  /// The current user's id.
  final String id;

  /// The current user's name.
  final String name;

  /// Whether the current user is anonymous.
  bool get isAnonymous => this == anonymous;

  /// Anonymous user which represents an unauthenticated user.
  static const anonymous = AuthenticationUser(id: '', email: '', name: '');

  @override
  List<Object?> get props => [
        email,
        id,
        name,
      ];
}

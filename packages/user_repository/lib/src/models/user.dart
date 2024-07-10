import 'package:firebase_authentication_client/firebase_authentication_client.dart';

/// {@template user}
/// User model represents the current user.
/// {@endtemplate}
class User extends AuthenticationUser {
  /// {@macro user}
  const User({
    required super.id,
    required super.email,
    required super.name,
    this.acceptCalls = true,
  });

  /// Converts an [AuthenticationUser] instance to [User].
  factory User.fromAuthenticationUser(AuthenticationUser authenticationUser) =>
      User(
        id: authenticationUser.id,
        email: authenticationUser.email,
        name: authenticationUser.name,
      );

  /// Converts a `Map<String, dynamic>` instance to [User].
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        acceptCalls: json['accept_calls'] as bool,
      );

  /// Whether the current user can accept calls.
  final bool acceptCalls;

  /// Whether the current user is anonymous.
  @override
  bool get isAnonymous => this == anonymous;

  /// Anonymous user which represents an unauthenticated user.
  static const User anonymous = User(id: '', email: '', name: '');

  /// Converts current [User] instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
    };
  }
}

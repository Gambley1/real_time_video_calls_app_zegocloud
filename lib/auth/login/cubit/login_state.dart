part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isFailure => this == LoginStatus.failure;
}

class LoginState {
  const LoginState._({
    required this.email,
    required this.password,
    required this.status,
  });

  const LoginState.initial()
      : this._(
          email: const Email.pure(),
          password: const Password.pure(),
          status: LoginStatus.initial,
        );

  final Email email;
  final Password password;
  final LoginStatus status;

  LoginState copyWith({
    Email? email,
    Password? password,
    LoginStatus? status,
  }) {
    return LoginState._(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}

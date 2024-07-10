part of 'sign_up_cubit.dart';

enum SignUpStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == SignUpStatus.loading;
  bool get isSuccess => this == SignUpStatus.success;
  bool get isFailure => this == SignUpStatus.failure;
}

class SignUpState extends Equatable {
  const SignUpState._({
    required this.name,
    required this.email,
    required this.password,
    required this.status,
  });

  const SignUpState.initial()
      : this._(
          name: const Username.pure(),
          email: const Email.pure(),
          password: const Password.pure(),
          status: SignUpStatus.initial,
        );

  final Email email;
  final Password password;
  final Username name;
  final SignUpStatus status;

  SignUpState copyWith({
    Email? email,
    Password? password,
    Username? name,
    String? profilePicture,
    SignUpStatus? status,
  }) =>
      SignUpState._(
        email: email ?? this.email,
        password: password ?? this.password,
        name: name ?? this.name,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => <Object?>[
        email,
        password,
        name,
        status,
      ];
}

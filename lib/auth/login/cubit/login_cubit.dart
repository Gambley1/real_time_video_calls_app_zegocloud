import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const LoginState.initial());

  final UserRepository _userRepository;

  void reset() {
    const email = Email.pure();
    const password = Password.dirty();
    final newState = state.copyWith(
      email: email,
      password: password,
      status: LoginStatus.initial,
    );
    emit(newState);
  }

  Future<void> onSubmit({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      await _userRepository.logInWithPassword(email: email, password: password);

      emit(state.copyWith(status: LoginStatus.success));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }
}

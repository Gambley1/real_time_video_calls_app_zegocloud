import 'dart:async';

import 'package:bloc/bloc.dart' show Cubit;
import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const SignUpState.initial());

  final UserRepository _userRepository;

  void reset() {
    const password = Password.pure();
    const name = Username.pure();
    final newState = state.copyWith(
      password: password,
      name: name,
      status: SignUpStatus.initial,
    );
    emit(newState);
  }

  Future<void> onSubmit({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: SignUpStatus.loading));

    try {
      await _userRepository.signUpWithPassword(
        email: email,
        password: password,
        name: name,
      );

      emit(state.copyWith(status: SignUpStatus.success));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: SignUpStatus.failure));
    }
  }
}

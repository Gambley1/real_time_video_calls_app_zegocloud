import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_video_calls_app_zegocloud/auth/sign_up/sign_up.dart';

class SignUpFormListener extends StatelessWidget {
  const SignUpFormListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (_, state) {
        // final status = state.status;

        // final snackMessage = switch ('') {
        //   _ when status.isFailure => 'Something went wrong!',
        //   _ => null,
        // };
        // if (snackMessage == null) return;
        // context.showSnackBar(snackMessage);
      },
      listenWhen: (p, c) => p.status != c.status,
      child: child,
    );
  }
}

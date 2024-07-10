import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_video_calls_app_zegocloud/auth/login/login.dart';

class LoginFormListener extends StatelessWidget {
  const LoginFormListener({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        // final status = state.status;
        // final snackMessage = switch ('') {
        //   _ when status.isFailure => 'Something went wrong!',
        //   _ => null,
        // };
        // if (snackMessage == null) return;
        // context.showSnackBar(snackMessage);
      },
      child: child,
    );
  }
}

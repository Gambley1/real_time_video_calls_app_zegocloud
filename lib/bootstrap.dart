import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:real_time_video_calls_app_zegocloud/app/app.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

typedef AppBuilder = FutureOr<Widget> Function();

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    dev.log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(AppBuilder builder) async {
  FlutterError.onError = (details) {
    dev.log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

      await Firebase.initializeApp();

      Bloc.observer = AppBlocObserver();

      await ZegoUIKit().initLog().then((value) async {
        ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
          [ZegoUIKitSignalingPlugin()],
        );

        runApp(await builder());
      });
    },
    (error, stackTrace) {
      dev.log('runZonedGuarded error', error: error, stackTrace: stackTrace);
    },
  );
}

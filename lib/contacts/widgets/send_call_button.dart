import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

enum CallType { voiceCall, videoCall }

class SendCallButton extends StatelessWidget {
  const SendCallButton({
    required this.callType,
    required this.userId,
    required this.name,
    required this.canAcceptCalls,
    super.key,
  });

  final CallType callType;
  final String userId;
  final String name;
  final bool canAcceptCalls;

  @override
  Widget build(BuildContext context) {
    return ZegoSendCallInvitationButton(
      isVideoCall: switch (callType) {
        CallType.videoCall => true,
        CallType.voiceCall => false,
      },
      invitees: [
        ZegoUIKitUser(id: userId, name: name),
      ],
      resourceID: 'zego_call',
      iconSize: const Size(40, 40),
      buttonSize: const Size(50, 50),
      onWillPressed: () {
        if (!canAcceptCalls) {
          showAdaptiveDialog<void>(
            context: context,
            builder: (context) {
              return AlertDialog.adaptive(
                title: const Text(
                  "User doesn't accept calls",
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  if (Platform.isIOS)
                    CupertinoDialogAction(
                      onPressed: context.pop,
                      child: const Text('OK'),
                    )
                  else
                    ElevatedButton(
                      onPressed: context.pop,
                      child: const Text('OK'),
                    ),
                ],
              );
            },
          );
          return Future.value(false);
        }
        return Future.value(true);
      },
    );
  }
}

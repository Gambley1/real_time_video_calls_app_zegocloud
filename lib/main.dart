import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:real_time_video_calls_app_zegocloud/app/app.dart';
import 'package:real_time_video_calls_app_zegocloud/bootstrap.dart';
import 'package:user_repository/user_repository.dart';

void main() => bootstrap(() async {
      final firebaseAuthenticationClient = FirebaseAuthenticationClient();
      final userRepository =
          UserRepository(authenticationClient: firebaseAuthenticationClient);

      return App(
        userRepository: userRepository,
        user: await userRepository.user.first,
      );
    });

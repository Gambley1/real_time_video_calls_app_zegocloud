import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_video_calls_app_zegocloud/app/app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:user_repository/user_repository.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: AppConstrainedScrollView(
        child: Column(
          children: [
            ...ListTile.divideTiles(
              context: context,
              tiles: [
                StreamBuilder<bool>(
                  stream: userRepository.canAcceptCalls(),
                  builder: (context, snapshot) {
                    final canAcceptCalls = snapshot.data ?? true;

                    return ListTile(
                      title: const Text('Calls'),
                      subtitle: Text(
                        'Manage whether people can call you',
                        style: context.bodySmall?.apply(color: AppColors.grey),
                      ),
                      trailing: Switch(
                        value: canAcceptCalls,
                        onChanged: (acceptCalls) => context
                            .read<UserRepository>()
                            .changeAcceptCalls(acceptCalls: acceptCalls),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Log out'),
                  trailing: const Icon(LucideIcons.logOut),
                  textColor: AppColors.red,
                  iconColor: AppColors.red,
                  onTap: () =>
                      context.read<AppBloc>().add(const AppLogoutRequested()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_video_calls_app_zegocloud/app/app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
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

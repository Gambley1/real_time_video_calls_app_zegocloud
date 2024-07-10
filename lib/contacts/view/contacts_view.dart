import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_video_calls_app_zegocloud/app/app.dart';
import 'package:real_time_video_calls_app_zegocloud/contacts/contacts.dart';
import 'package:user_repository/user_repository.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final currentUser = context.select((AppBloc bloc) => bloc.state.user);

    return AppScaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<User>>(
            stream: userRepository.users,
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data == null) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (data.isEmpty) {
                return const Center(child: Text('No users found'));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final user = data[index];
                    if (user.id == currentUser.id) {
                      return const SizedBox.shrink();
                    }
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text(
                        user.email,
                        style: context.bodySmall?.apply(color: AppColors.grey),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (final callType in CallType.values)
                            SendCallButton(
                              callType: callType,
                              userId: user.id,
                              name: user.name,
                              canAcceptCalls: user.acceptCalls,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

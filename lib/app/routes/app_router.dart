import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_time_video_calls_app_zegocloud/app/app.dart';
import 'package:real_time_video_calls_app_zegocloud/auth/auth.dart';
import 'package:real_time_video_calls_app_zegocloud/contacts/contacts.dart';
import 'package:real_time_video_calls_app_zegocloud/home/home.dart';
import 'package:real_time_video_calls_app_zegocloud/settings/settings.dart';

class AppRouter {
  AppRouter();

  GoRouter router(AppBloc appBloc) => GoRouter(
        navigatorKey: navigatorKey,
        initialLocation: AppRoutes.contacts.route,
        routes: [
          GoRoute(
            path: AppRoutes.auth.route,
            name: AppRoutes.auth.name,
            builder: (context, state) => const AuthPage(),
          ),
          StatefulShellRoute.indexedStack(
            parentNavigatorKey: navigatorKey,
            builder: (context, state, navigationShell) {
              return HomePage(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.contacts.route,
                    name: AppRoutes.contacts.name,
                    builder: (context, state) => const ContactsView(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.settings.route,
                    name: AppRoutes.settings.name,
                    builder: (context, state) => const SettingsView(),
                  ),
                ],
              ),
            ],
          ),
        ],
        redirect: (context, state) {
          final authenticated = appBloc.state.status == AppStatus.authenticated;
          final authenticating = state.matchedLocation == AppRoutes.auth.route;
          final isInContacts =
              state.matchedLocation == AppRoutes.contacts.route;

          if (isInContacts && !authenticated) return AppRoutes.auth.route;
          if (!authenticated) return AppRoutes.auth.route;
          if (authenticating && authenticated) {
            return AppRoutes.contacts.route;
          }

          return null;
        },
        refreshListenable: GoRouterAppBlocRefreshStream(appBloc.stream),
      );
}

/// {@template go_router_refresh_stream}
/// A [ChangeNotifier] that notifies listeners when a [Stream] emits a value.
/// This is used to rebuild the UI when the [AppBloc] emits a new state.
/// {@endtemplate}
class GoRouterAppBlocRefreshStream extends ChangeNotifier {
  /// {@macro go_router_refresh_stream}
  GoRouterAppBlocRefreshStream(Stream<AppState> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((appState) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

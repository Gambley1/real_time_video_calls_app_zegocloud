enum AppRoutes {
  contacts('/contacts'),
  auth('/auth'),
  settings('/settings');

  const AppRoutes(this.route);

  final String route;
}

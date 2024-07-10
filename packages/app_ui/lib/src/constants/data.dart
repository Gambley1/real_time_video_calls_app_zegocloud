// ignore_for_file: public_member_api_docs

import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class NavBarItem {
  const NavBarItem({
    this.icon,
    this.label,
    this.child,
  });

  final String? label;
  final Widget? child;
  final IconData? icon;

  String? get tooltip => label;
}

/// Navigation bar items
List<NavBarItem> mainNavigationBarItems() => <NavBarItem>[
      const NavBarItem(icon: LucideIcons.house, label: 'Home'),
      const NavBarItem(icon: LucideIcons.settings, label: 'Settings'),
    ];

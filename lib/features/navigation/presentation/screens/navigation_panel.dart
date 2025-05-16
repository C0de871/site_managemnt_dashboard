import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/navigation/presentation/widgets/brand_header.dart';
import 'package:site_managemnt_dashboard/features/navigation/presentation/widgets/logout_button.dart';
import 'package:site_managemnt_dashboard/features/navigation/presentation/widgets/navigation_items.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 250,
      color: colorScheme.surface,
      child: Column(
        children: [
          // Brand Image
          BrandHeader(),

          // Navigation Items
          Expanded(child: NavigationItems()),

          // Logout Button
          LogoutButton(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/sites_cubit.dart';
import 'sites_action_buttons.dart';

class SitesFilterBar extends StatelessWidget {
  const SitesFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          BlocBuilder<SitesCubit, SitesState>(
            builder: (context, state) {
              if (state.sitesStatus.isLoaded) {
                return const SitesActionButtons();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

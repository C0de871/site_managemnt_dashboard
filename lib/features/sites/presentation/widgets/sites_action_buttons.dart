import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/sites_cubit.dart';

class SitesActionButtons extends StatelessWidget {
  const SitesActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<SitesCubit, SitesState>(
      builder: (context, state) {
        final hasSelectedSites = state.selectedSiteIds.isNotEmpty;

        return Row(
          children: [
            // add site Button
            ElevatedButton.icon(
              onPressed: () {
                context.read<SitesCubit>().showAddEditSiteDialog(context);
              },
              icon: const Icon(Icons.add),
              label: Text('Add new site'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.tertiary,
                foregroundColor: colorScheme.onTertiary,
                // disabledBackgroundColor: colorScheme.errorContainer
                //     .withValues(alpha: 0.3),
                // disabledForegroundColor: colorScheme.onErrorContainer
                //     .withValues(alpha: 0.5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
            SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed:
                  hasSelectedSites
                      ? () {
                        context.read<SitesCubit>().deleteSelectedSites();
                      }
                      : null,
              icon: const Icon(Icons.delete),
              label: Text('Delete (${state.selectedSiteIds.length})'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.errorContainer,
                foregroundColor: colorScheme.onErrorContainer,
                disabledBackgroundColor: colorScheme.errorContainer.withValues(
                  alpha: 0.3,
                ),
                disabledForegroundColor: colorScheme.onErrorContainer
                    .withValues(alpha: 0.5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ],
        );

        // return const SizedBox.shrink();
      },
    );
  }
}

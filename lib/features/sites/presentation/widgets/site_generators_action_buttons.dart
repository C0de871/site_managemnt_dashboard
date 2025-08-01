import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/sites/presentation/cubit/sites_cubit.dart';

class SiteGeneratorsActionButtons extends StatelessWidget {
  const SiteGeneratorsActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<SitesCubit, SitesState>(
      builder: (context, state) {
        if (state.generatorStatus.isLoaded) {
          final hasSelectedGenerators = state.selectedGeneratorIds.isNotEmpty;

          return Row(
            children: [
              // Delete Button
              // ElevatedButton.icon(
              //   onPressed:
              //       hasSelectedGenerators
              //           ? () {
              //             // context.read<SitesCubit>().del();
              //           }
              //           : null,
              //   icon: const Icon(Icons.delete),
              //   label: Text('Delete (${state.selectedGeneratorIds.length})'),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: colorScheme.errorContainer,
              //     foregroundColor: colorScheme.onErrorContainer,
              //     disabledBackgroundColor: colorScheme.errorContainer
              //         .withValues(alpha: 0.3),
              //     disabledForegroundColor: colorScheme.onErrorContainer
              //         .withValues(alpha: 0.5),
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 16,
              //       vertical: 10,
              //     ),
              //   ),
              // ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

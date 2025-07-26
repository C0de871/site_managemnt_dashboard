import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/parts_cubit.dart';

class PartsActionButtons extends StatelessWidget {
  const PartsActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<PartsCubit, PartsState>(
      builder: (context, state) {
        if (state.partsStatus.isLoaded) {
          final hasSelectedParts = state.selectedPartIds.isNotEmpty;

          return Row(
            children: [
              // add site Button
              ElevatedButton.icon(
                onPressed: () {
                  context.read<PartsCubit>().showAddEditPartDialog(context);
                },
                icon: const Icon(Icons.add),
                label: Text('Add new part'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.tertiary,
                  foregroundColor: colorScheme.onTertiary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
              SizedBox(width: 16),

              //! Delete Button
              ElevatedButton.icon(
                onPressed:
                    hasSelectedParts
                        ? () {
                          context.read<PartsCubit>().deleteSelectedParts();
                        }
                        : null,
                icon: const Icon(Icons.delete),
                label: Text('Delete (${state.selectedPartIds.length})'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.errorContainer,
                  foregroundColor: colorScheme.onErrorContainer,
                  disabledBackgroundColor: colorScheme.errorContainer
                      .withValues(alpha: 0.3),
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
        }

        return const SizedBox.shrink();
      },
    );
  }
}

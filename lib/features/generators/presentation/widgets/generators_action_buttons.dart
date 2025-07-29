import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/generators_cubit.dart';

class GeneratorsActionButtons extends StatelessWidget {
  const GeneratorsActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final cubit = context.read<GeneratorsEnginesCubit>();
    return BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
      builder: (context, state) {
        if (state.generatorsStatus.isLoaded) {
          final hasSelectedGenerators = state.selectedGeneratorIds.isNotEmpty;

          return Row(
            children: [
              //! add generator Button
              ElevatedButton.icon(
                onPressed: () {
                  cubit.showGeneratorDialog(context);
                },
                icon: const Icon(Icons.add),
                label: Text('Add new generator'),
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
              ElevatedButton.icon(
                onPressed:
                    hasSelectedGenerators
                        ? () {
                          context
                              .read<GeneratorsEnginesCubit>()
                              .deleteSelectedGenerators();
                        }
                        : null,
                icon: const Icon(Icons.delete),
                label: Text('Delete (${state.selectedGeneratorIds.length})'),
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

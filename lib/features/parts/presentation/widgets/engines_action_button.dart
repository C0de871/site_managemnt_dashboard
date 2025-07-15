import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/parts_cubit.dart';

class EnginesActionButtons extends StatelessWidget {
  const EnginesActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<PartsCubit, PartsState>(
      builder: (context, state) {
        if (state.partsStatus.isLoaded) {
          final hasSelectedEngines = state.selectedEngineIds.isNotEmpty;

          return Row(
            children: [
              // Delete Button
              // ElevatedButton.icon(
              //   onPressed:
              //       hasSelectedEngines
              //           ? () {
              //             context.read<PartsCubit>().deleteSelectedEngines();
              //           }
              //           : null,
              //   icon: const Icon(Icons.delete),
              //   label: Text('Delete (${state.selectedEngineIds.length})'),
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

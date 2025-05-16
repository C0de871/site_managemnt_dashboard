import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/reports_cubit.dart';

class ReportsActionButtons extends StatelessWidget {
  const ReportsActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        if (state is ReportsLoaded) {
          final hasSelectedReports = state.selectedReportIds.isNotEmpty;

          return Row(
            children: [
              // Export Button
              ElevatedButton.icon(
                onPressed: () {
                  context.read<ReportsCubit>().exportReportsToExcel();
                },
                icon: const Icon(Icons.download),
                label: const Text('Export'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.secondaryContainer,
                  foregroundColor: colorScheme.onSecondaryContainer,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Delete Button
              ElevatedButton.icon(
                onPressed:
                    hasSelectedReports
                        ? () {
                          context.read<ReportsCubit>().deleteSelectedReports();
                        }
                        : null,
                icon: const Icon(Icons.delete),
                label: Text('Delete (${state.selectedReportIds.length})'),
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

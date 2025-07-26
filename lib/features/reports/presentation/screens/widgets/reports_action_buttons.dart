import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/reports_cubit.dart';
import '../../dialogs/choose_date.dart';

class ReportsActionButtons extends StatelessWidget {
  const ReportsActionButtons({super.key});

  void _showExportDialog(BuildContext context) {
    final cubit = context.read<ReportsCubit>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => ExportDateRangeDialog(
            onExport: (startDate, endDate) async {
              log('Exporting from $startDate to $endDate');
              await cubit.exportReportsToExcel(startDate, endDate);
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        final hasSelectedReports = state.selectedReportIds.isNotEmpty;

        return Row(
          children: [
            // Export Button
            ElevatedButton.icon(
              onPressed: () => _showExportDialog(context),
              icon: const Icon(Icons.download),
              label: const Text('Export All'),
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
            // ElevatedButton.icon(
            //   onPressed:
            //       hasSelectedReports
            //           ? () {
            //             context.read<ReportsCubit>().showConfirmDeleteDialog();
            //           }
            //           : null,
            //   icon: const Icon(Icons.delete),
            //   label: Text('Delete (${state.selectedReportIds.length})'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: colorScheme.errorContainer,
            //     foregroundColor: colorScheme.onErrorContainer,
            //     disabledBackgroundColor: colorScheme.errorContainer.withValues(
            //       alpha: 0.3,
            //     ),
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

        return const SizedBox.shrink();
      },
    );
  }
}

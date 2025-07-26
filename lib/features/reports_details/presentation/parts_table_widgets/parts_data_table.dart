import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/shared/widgets/my_data_source.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/cubit/report_details_cubit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../parts/domain/entities/part_entity.dart';

class PartsDataTable extends StatefulWidget {
  const PartsDataTable({super.key});

  @override
  State<PartsDataTable> createState() => _PartsDataTableState();
}

class _PartsDataTableState extends State<PartsDataTable> {
  final DataGridController _dataGridController = DataGridController();
  final int _rowsPerPage = 20;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ReportDetailsCubit, ReportDetailsState>(
      builder: (context, state) {
        if (state.reportDetails?.parts.isEmpty ?? false) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No parts found',
                  style: TextStyle(
                    fontSize: 20,
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
        final partColumns = [
          // SelectionColumnConfig<PartEntity>(
          //   idExtractor: (part) => part.id.toString(),
          //   selectedIds: state.selectedPartIds,
          //   onToggleSelection: context.read<PartsCubit>().togglePartSelection,
          // ),
          ColumnConfig<PartEntity>(
            columnName: 'Code',
            displayName: 'Part Code',
            valueExtractor: (part) => part.code ?? "غير معروف",
          ),
          ColumnConfig<PartEntity>(
            columnName: 'Name',
            displayName: 'Part Name',
            valueExtractor: (part) => part.name,
          ),

          ColumnConfig<PartEntity>(
            columnName: 'isFaulty',
            displayName: 'Is Faulty',
            valueExtractor: (part) => part.isFaulty == true ? "yes" : "false",
          ),
          ColumnConfig<PartEntity>(
            columnName: 'quantity',
            displayName: 'Quantity',
            valueExtractor: (part) => part.quantity.toString(),
          ),
          ColumnConfig<PartEntity>(
            columnName: 'faultyQuantity',
            displayName: 'Faulty Quantity',
            valueExtractor: (part) => part.faultyQuantity.toString(),
          ),
          ColumnConfig<PartEntity>(
            columnName: 'Note',
            displayName: 'note',
            valueExtractor: (part) => part.note.toString(),
          ),
          ColumnConfig<PartEntity>(
            columnName: 'lastReplacementDate',
            displayName: 'Last Replacement Date',
            valueExtractor: (part) => part.fomattedLastReplacementDate,
          ),
          ColumnConfig<PartEntity>(
            columnName: 'generatorHoursAtLastReplacement',
            displayName: 'Generator Hours At Last Replacement',
            valueExtractor:
                (part) =>
                    part.generatorHoursAtLastReplacement?.toString() ?? '-',
          ),
          // ActionsColumnConfig<PartEntity>(
          //   actions: [
          //     ActionButton<PartEntity>(
          //       icon: Icons.visibility,
          //       tooltip: 'View ',
          //       color: colorScheme.onSurface,
          //       onPressed:
          //           (report) => context
          //               .read<PartsCubit>()
          //               .setCurrentPartEnginesId(report.id),
          //     ),
          //     ActionButton<PartEntity>(
          //       icon: Icons.edit,
          //       tooltip: 'edit ',
          //       color: colorScheme.primary,
          //       onPressed:
          //           (report) => context
          //               .read<PartsCubit>()
          //               .setCurrentPartEnginesId(report.id),
          //     ),
          //     ActionButton<PartEntity>(
          //       icon: Icons.delete,
          //       tooltip: 'delete ',
          //       color: colorScheme.error,
          //       onPressed:
          //           (report) => context
          //               .read<PartsCubit>()
          //               .setCurrentPartEnginesId(report.id),
          //     ),
          //   ],
          // ),
        ];

        // Then create your data source
        final dataSource = CustomDataSource<PartEntity>(
          data: state.reportDetails!.parts,
          columns: partColumns,
        );

        // Calculate total pages
        final int totalPages =
            (state.reportDetails!.parts.length / _rowsPerPage).ceil();

        // Ensure current page is valid
        if (_currentPage >= totalPages && totalPages > 0) {
          _currentPage = totalPages - 1;
        }

        log("total pages: $totalPages");
        log("current page: $_currentPage");
        log("parts: ${state.reportDetails!.parts}");

        return Column(
          children: [
            Expanded(
              child: SfDataGrid(
                onQueryRowHeight: (details) {
                  return details.getIntrinsicRowHeight(details.rowIndex);
                },
                source: dataSource,
                controller: _dataGridController,
                allowSorting: true, // We're handling sorting in Cubit
                selectionMode: SelectionMode.multiple,
                navigationMode: GridNavigationMode.cell,
                frozenColumnsCount: 1, // Freeze the checkbox column
                highlightRowOnHover: true,
                // allowFiltering: true,
                // Use pagination instead of fixed row sizes
                rowsPerPage: _rowsPerPage,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                columnWidthMode: ColumnWidthMode.fill,
                columns: dataSource.getGridColumns(),
              ),
            ),

            SizedBox(
              height: 60,
              child: SfDataPager(
                delegate: dataSource,
                pageCount:
                    (state.reportDetails!.parts.length / _rowsPerPage)
                        .ceil()
                        .toDouble(),
              ),
            ),
          ],
        );
      },
    );
  }
}

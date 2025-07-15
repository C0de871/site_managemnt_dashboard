import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/shared/widgets/my_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../core/Routes/app_routes.dart';
import '../../../domain/entities/report_entity.dart';
import '../../cubits/reports_cubit.dart';

class ReportsDataTable extends StatefulWidget {
  const ReportsDataTable({super.key});

  @override
  State<ReportsDataTable> createState() => _ReportsDataTableState();
}

class _ReportsDataTableState extends State<ReportsDataTable> {
  // late GenericDataSource<ReportEntity> _dataSource;
  final DataGridController _dataGridController = DataGridController();
  final int _rowsPerPage = 20;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final reportCubit = context.read<ReportsCubit>();

    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        final reportColumns = [
          SelectionColumnConfig<ReportEntity>(
            idExtractor: (report) => report.id.toString(),
            selectedIds: state.selectedReportIds,
            onToggleSelection:
                context.read<ReportsCubit>().toggleReportSelection,
          ),
          ColumnConfig<ReportEntity>(
            columnName: 'siteCode',
            displayName: 'Site Code',
            valueExtractor: (report) => report.site.code,
          ),
          ColumnConfig<ReportEntity>(
            columnName: 'siteName',
            displayName: 'Site Name',
            valueExtractor: (report) => report.site.name,
          ),
          ColumnConfig<ReportEntity>(
            columnName: 'visitType',
            displayName: 'Visit Type',
            valueExtractor: (report) => report.visitType.arabicName,
          ),
          ColumnConfig<ReportEntity>(
            columnName: 'visitDate',
            displayName: 'Visit Date',
            valueExtractor:
                (report) =>
                    '${report.visitDate.day}/${report.visitDate.month}/${report.visitDate.year}',
          ),
          ActionsColumnConfig<ReportEntity>(
            actions: [
              ActionButton<ReportEntity>(
                icon: Icons.visibility,
                tooltip: 'View Details',
                onPressed: (report) => _showReportDetails(context, report),
                color: colorScheme.onSurface,
              ),
              // ActionButton<ReportEntity>(
              //   icon: Icons.delete,
              //   tooltip: 'Delete',
              //   onPressed:
              //       (report) => reportCubit.showConfirmDeleteDialog(report.id),
              //   color: colorScheme.error,
              // ),
            ],
          ),
        ];

        // Then create your data source
        final dataSource = CustomDataSource<ReportEntity>(
          data: state.filteredReports,
          columns: reportColumns,
        );

        // Calculate total pages
        final int totalPages =
            ((state.pagination?.totalItemsCount ?? 1) / _rowsPerPage).ceil();

        // Ensure current page is valid
        if (_currentPage >= totalPages && totalPages > 0) {
          _currentPage = totalPages - 1;
        }

        return Stack(
          children: [
            if (state.filteredReports.isEmpty && !state.reportsStatus.isLoading)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No reports found',
                      style: TextStyle(
                        fontSize: 20,
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //   const SizedBox(height: 8),
                    //   Text(
                    //     'Try changing your search criteria',
                    //     style: TextStyle(color: colorScheme.onSurfaceVariant),
                    //   ),
                    //   const SizedBox(height: 16),
                    //   ElevatedButton.icon(
                    //     onPressed: () => context.read<ReportsCubit>().loadReports(),
                    //     icon: const Icon(Icons.refresh),
                    //     label: const Text('Reset Filters'),
                    //   ),
                  ],
                ),
              ),

            if (state.reportsStatus.isLoading)
              Center(child: CircularProgressIndicator()),

            IgnorePointer(
              ignoring: state.reportsStatus.isLoading,
              child: Column(
                children: [
                  Expanded(
                    child: SfDataGrid(
                      source: dataSource,
                      controller: _dataGridController,
                      allowColumnsResizing: true,
                      columnResizeMode: ColumnResizeMode.onResizeEnd,
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
                    child: IgnorePointer(
                      ignoring: state.reportsStatus.isLoading,
                      child: SfDataPager(
                        delegate: dataSource,
                        pageCount: totalPages.toDouble(),
                        onPageNavigationEnd: (pageNumber) {
                          reportCubit.loadReports(page: pageNumber + 1);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

        // return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _showReportDetails(BuildContext context, ReportEntity report) {
    log(report.id.toString());
    Navigator.of(
      context,
      rootNavigator: false,
    ).pushNamed(AppRoutes.reportDetails, arguments: report.id.toString());
  }
}

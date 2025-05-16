import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/reports/presentation/screens/widgets/reports_data_source.dart';
import 'package:syncfusion_flutter_core/theme.dart';
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
  late ReportsDataSource _dataSource;
  final DataGridController _dataGridController = DataGridController();
  final int _rowsPerPage = 10;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        if (state is ReportsLoaded) {
          if (state.filteredReports.isEmpty) {
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
                    'No reports found',
                    style: TextStyle(
                      fontSize: 20,
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try changing your search criteria',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.read<ReportsCubit>().loadReports(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset Filters'),
                  ),
                ],
              ),
            );
          }
          // Initialize data source
          _dataSource = ReportsDataSource(
            reports: state.filteredReports,
            selectedReportIds: state.selectedReportIds,
            // startingRow: _currentPage * _rowsPerPage,
            onToggleSelection: (reportId) {
              context.read<ReportsCubit>().toggleReportSelection(reportId);
            },
            onViewDetails: (report) {
              _showReportDetails(context, report);
            },
            onDelete: (reportId) {
              // In a real app, we'd show a confirmation dialog first
              context.read<ReportsCubit>().toggleReportSelection(reportId);
              context.read<ReportsCubit>().deleteSelectedReports();
            },
          );

          // Calculate total pages
          final int totalPages =
              (state.filteredReports.length / _rowsPerPage).ceil();

          // Ensure current page is valid
          if (_currentPage >= totalPages && totalPages > 0) {
            _currentPage = totalPages - 1;
          }

          return Column(
            children: [
              // Data Grid
              Expanded(
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                    headerColor: colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.3,
                    ),
                    gridLineColor: colorScheme.outlineVariant.withValues(
                      alpha: 0.5,
                    ),
                    gridLineStrokeWidth: 1,
                    selectionColor: colorScheme.primaryContainer.withValues(
                      alpha: 0.3,
                    ),
                    rowHoverColor: colorScheme.primaryContainer.withValues(
                      alpha: 0.1,
                    ),
                  ),
                  child: SfDataGrid(
                    source: _dataSource,
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
                    columns: [
                      GridColumn(
                        columnName: 'selection',
                        width: 60,
                        label: Container(
                          alignment: Alignment.center,
                          child: const Text(''),
                        ),
                      ),
                      GridColumn(
                        columnName: 'siteCode',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.centerLeft,
                          child: const Text('Site Code'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'siteName',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.centerLeft,
                          child: const Text('Site Name'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'visitType',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.centerLeft,
                          child: const Text('Visit Type'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'visitDate',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.centerLeft,
                          child: const Text('Visit Date'),
                        ),
                      ),
                      GridColumn(
                        columnName: 'actions',
                        width: 130,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('Actions'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Pagination
              // _buildPagination(context, state.filteredReports.length),
              SizedBox(
                height: 60,
                child: SfDataPager(
                  delegate: _dataSource,
                  pageCount:
                      (state.filteredReports.length / _rowsPerPage)
                          .ceil()
                          .toDouble(),
                ),
              ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _showReportDetails(BuildContext context, ReportEntity report) {
    Navigator.of(
      context,
      rootNavigator: false,
    ).pushNamed(AppRoutes.reportDetails);
  }
}

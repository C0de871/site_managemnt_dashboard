import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../domain/entities/report_entity.dart';

class ReportsDataSource extends DataGridSource {
  final List<ReportEntity> reports;
  final Set<String> selectedReportIds;
  final Function(String) onToggleSelection;
  final Function(ReportEntity) onViewDetails;
  final Function(String) onDelete;
  // int startingRow = 0;
  // final int _rowsPerPage;

  ReportsDataSource({
    required this.reports,
    required this.selectedReportIds,
    required this.onToggleSelection,
    required this.onViewDetails,
    required this.onDelete,
    // required this.startingRow,
  }) {
    _buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void _buildDataGridRows() {
    _dataGridRows =
        reports
            .map<DataGridRow>(
              (report) => DataGridRow(
                cells: [
                  DataGridCell<String>(
                    columnName: 'selection',
                    value: report.id.toString(),
                  ),
                  DataGridCell<String>(
                    columnName: 'siteCode',
                    value: report.site.code,
                  ),
                  DataGridCell<String>(
                    columnName: 'siteName',
                    value: report.site.name,
                  ),
                  DataGridCell<String>(
                    columnName: 'visitType',
                    value: report.visitType.arabicName,
                  ),
                  DataGridCell<String>(
                    columnName: 'visitDate',
                    value:
                        '${report.visitDate.day}/${report.visitDate.month}/${report.visitDate.year}',
                  ),
                  DataGridCell<String>(
                    columnName: 'actions',
                    value: report.id.toString(),
                  ),
                ],
              ),
            )
            .toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final reportId = row.getCells().first.value;
    // final lastCell = row.getCells().last.value;
    final report = reports.firstWhere((r) => r.id == reportId);
    final isSelected = selectedReportIds.contains(reportId);

    return DataGridRowAdapter(
      cells:
          row.getCells().map<Widget>((cell) {
            if (cell.columnName == 'selection') {
              // Selection checkbox
              return Container(
                alignment: Alignment.center,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) => onToggleSelection(reportId),
                ),
              );
            } else if (cell.columnName == 'actions') {
              // Action buttons
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.visibility, size: 20),
                    visualDensity: VisualDensity.compact,
                    tooltip: 'View Details',
                    onPressed: () => onViewDetails(report),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Delete',
                    onPressed: () => onDelete(reportId),
                  ),
                ],
              );
            } else {
              // Regular data cell
              return Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  cell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }
          }).toList(),
    );
  }

  @override
  int compare(DataGridRow? a, DataGridRow? b, SortColumnDetails sortColumn) {
    // This would be used if we allow column sorting
    if (a == null || b == null) return 0;

    final aCellValue =
        a
            .getCells()
            .firstWhere((cell) => cell.columnName == sortColumn.name)
            .value
            .toString();
    final bCellValue =
        b
            .getCells()
            .firstWhere((cell) => cell.columnName == sortColumn.name)
            .value
            .toString();

    return sortColumn.sortDirection == DataGridSortDirection.ascending
        ? aCellValue.compareTo(bCellValue)
        : bCellValue.compareTo(aCellValue);
  }
}

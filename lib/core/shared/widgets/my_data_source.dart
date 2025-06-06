import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// Configuration class that defines how each column should behave
class ColumnConfig<T> {
  final String columnName;
  final String displayName;
  final String Function(T)
  valueExtractor; // Function to get value from your data object
  final Widget Function(T, dynamic)?
  customCellBuilder; // Optional custom cell widget
  final bool sortable;
  final double? width;
  final bool visible;

  const ColumnConfig({
    required this.columnName,
    required this.displayName,
    required this.valueExtractor,
    this.customCellBuilder,
    this.sortable = true,
    this.width,
    this.visible = true,
  });
}

// Special column types for common use cases
class SelectionColumnConfig<T> extends ColumnConfig<T> {
  final String Function(T)
  idExtractor; // Function to get unique ID from your data
  final Set<String> selectedIds;
  final Function(String) onToggleSelection;

  SelectionColumnConfig({
    required this.idExtractor,
    required this.selectedIds,
    required this.onToggleSelection,
    super.columnName = 'selection',
    super.displayName = '',
    super.width = 60,
  }) : super(
         valueExtractor: (item) => idExtractor(item),
         sortable: false,
         customCellBuilder: (item, value) {
           final id = idExtractor(item);
           final isSelected = selectedIds.contains(id);
           return Container(
             alignment: Alignment.center,
             child: Checkbox(
               value: isSelected,
               onChanged: (_) => onToggleSelection(id),
             ),
           );
         },
       );
}

class ActionsColumnConfig<T> extends ColumnConfig<T> {
  final List<ActionButton<T>> actions;

  ActionsColumnConfig({
    required this.actions,
    super.columnName = 'actions',
    super.displayName = 'Actions',
    super.width = 120,
  }) : super(
         valueExtractor: (item) => '',
         sortable: false,
         customCellBuilder: (item, value) {
           return Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children:
                 actions
                     .map(
                       (action) => IconButton(
                         icon: Icon(action.icon, size: 20, color: action.color),
                         visualDensity: VisualDensity.compact,
                         tooltip: action.tooltip,
                         onPressed: () => action.onPressed(item),
                       ),
                     )
                     .toList(),
           );
         },
       );
}

// Configuration for action buttons
class ActionButton<T> {
  final IconData icon;
  final String tooltip;
  final Function(T) onPressed;
  final bool Function(T)?
  isVisible; // Optional function to conditionally show button
  final Color color;

  const ActionButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.color,
    this.isVisible,
  });
}

// The generic, reusable DataGrid source
class CustomDataSource<T> extends DataGridSource {
  final List<T> data;
  final List<ColumnConfig<T>> columns;

  CustomDataSource({required this.data, required this.columns}) {
    _buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];

  void _buildDataGridRows() {
    _dataGridRows =
        data.map<DataGridRow>((item) {
          return DataGridRow(
            cells:
                columns
                    .where((col) => col.visible) // Only include visible columns
                    .map<DataGridCell>((column) {
                      final value = column.valueExtractor(item);
                      return DataGridCell<dynamic>(
                        columnName: column.columnName,
                        value: value,
                      );
                    })
                    .toList(),
          );
        }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // Find the corresponding data item for this row
    final rowIndex = _dataGridRows.indexOf(row);
    if (rowIndex == -1 || rowIndex >= data.length) return null;

    final dataItem = data[rowIndex];

    return DataGridRowAdapter(
      cells:
          row.getCells().map<Widget>((cell) {
            // Find the column configuration for this cell
            final column = columns.firstWhere(
              (col) => col.columnName == cell.columnName,
              orElse:
                  () => throw Exception('Column ${cell.columnName} not found'),
            );

            // Use custom cell builder if provided, otherwise use default
            if (column.customCellBuilder != null) {
              return column.customCellBuilder!(dataItem, cell.value);
            } else {
              // Default cell rendering for simple text display
              return Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  cell.value?.toString() ?? '',
                  softWrap: true,
                  // overflow: TextOverflow.ellipsis,
                ),
              );
            }
          }).toList(),
    );
  }

  @override
  int compare(DataGridRow? a, DataGridRow? b, SortColumnDetails sortColumn) {
    if (a == null || b == null) return 0;

    // Find the column configuration to check if sorting is allowed
    final column = columns.firstWhere(
      (col) => col.columnName == sortColumn.name,
      orElse: () => throw Exception('Column ${sortColumn.name} not found'),
    );

    if (!column.sortable) return 0;

    final aCellValue =
        a
            .getCells()
            .firstWhere((cell) => cell.columnName == sortColumn.name)
            .value
            ?.toString() ??
        '';

    final bCellValue =
        b
            .getCells()
            .firstWhere((cell) => cell.columnName == sortColumn.name)
            .value
            ?.toString() ??
        '';

    return sortColumn.sortDirection == DataGridSortDirection.ascending
        ? aCellValue.compareTo(bCellValue)
        : bCellValue.compareTo(aCellValue);
  }

  // Method to update data and refresh the grid
  void updateData(List<T> newData) {
    data.clear();
    data.addAll(newData);
    _buildDataGridRows();
    notifyListeners(); // This will refresh the DataGrid
  }

  // Method to get column configurations for DataGrid widget
  List<GridColumn> getGridColumns() {
    return columns
        .where((col) => col.visible)
        .map(
          (column) => GridColumn(
            columnName: column.columnName,
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                column.displayName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            width:
                column.width ??
                double.nan, // Use default width if not specified
            allowSorting: column.sortable,
          ),
        )
        .toList();
  }
}

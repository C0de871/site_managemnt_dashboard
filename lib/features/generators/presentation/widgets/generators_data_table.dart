import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/shared/widgets/my_data_source.dart';
import 'package:site_managemnt_dashboard/core/shared/widgets/not_found_widget.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/cubit/generators_cubit.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../domain/entities/generator_entity.dart';

class GeneratorsDataTable extends StatefulWidget {
  const GeneratorsDataTable({
    super.key,
    required this.isEmpty,
    required this.emptyMessage,
    required this.showSiteColumn,
    required this.selectedGeneratorIds,
    required this.generators,
    required this.onToggleSelection,
  });

  final bool isEmpty;
  final String emptyMessage;
  final bool showSiteColumn;
  final Set<String> selectedGeneratorIds;
  final List<GeneratorEntity> generators;
  final Function(String) onToggleSelection;

  @override
  State<GeneratorsDataTable> createState() => _GeneratorsDataTableState();
}

class _GeneratorsDataTableState extends State<GeneratorsDataTable> {
  final DataGridController _dataGridController = DataGridController();
  final int _rowsPerPage = 10;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<GeneratorsEnginesCubit>();
    if (widget.generators.isEmpty) {
      return NotFoundWidget(message: widget.emptyMessage);
    }
    final generatorColumns = [
      SelectionColumnConfig<GeneratorEntity>(
        idExtractor: (generator) => generator.id.toString(),
        selectedIds: widget.selectedGeneratorIds,
        onToggleSelection: widget.onToggleSelection,
      ),
      ColumnConfig<GeneratorEntity>(
        columnName: 'brand',
        displayName: 'Brand',
        valueExtractor: (generator) => generator.brand.brand,
      ),
      ColumnConfig<GeneratorEntity>(
        columnName: 'engine_capacity',
        displayName: 'Engine Capacity',
        valueExtractor:
            (generator) => generator.engine.engineCapacity.capacity.toString(),
      ),

      ColumnConfig<GeneratorEntity>(
        columnName: 'engine_brand',
        displayName: 'Engine Brand',
        valueExtractor: (generator) => generator.engine.engineBrand.brand,
      ),
      ColumnConfig<GeneratorEntity>(
        columnName: 'initial_meter',
        displayName: 'Initial Meter',
        valueExtractor: (generator) => generator.initalMeter,
      ),
      ColumnConfig<GeneratorEntity>(
        columnName: 'site',
        displayName: 'Site',
        visible: widget.showSiteColumn,
        valueExtractor: (generator) => generator.site?.name ?? 'No site',
      ),
      ActionsColumnConfig(
        actions: [
          ActionButton<GeneratorEntity>(
            icon: Icons.edit,
            tooltip: 'Edit',
            onPressed: (generator) {
              cubit.showGeneratorDialog(context, generator: generator);
            },
            color: colorScheme.primary,
          ),
          ActionButton<GeneratorEntity>(
            icon: Icons.delete,
            tooltip: 'Delete',
            onPressed: (generator) {},
            color: colorScheme.error,
          ),
        ],
      ),
    ];

    // Then create your data source
    final dataSource = CustomDataSource<GeneratorEntity>(
      data: widget.generators,
      columns: generatorColumns,
    );

    // Calculate total pages
    final int totalPages = (widget.generators.length / _rowsPerPage).ceil();

    // Ensure current page is valid
    if (_currentPage >= totalPages && totalPages > 0) {
      _currentPage = totalPages - 1;
    }

    return SizedBox(
      height: 500,
      child: Column(
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
                  (widget.generators.length / _rowsPerPage).ceil().toDouble(),
            ),
          ),
        ],
      ),
    );
  }
}

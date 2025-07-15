import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/shared/widgets/my_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../engines/domain/entities/engine_entity.dart';
import '../cubit/parts_cubit.dart';

class EnginesDataTable extends StatefulWidget {
  const EnginesDataTable({super.key, required this.partId});
  final int partId;

  @override
  State<EnginesDataTable> createState() => _EnginesDataTableState();
}

class _EnginesDataTableState extends State<EnginesDataTable> {
  final DataGridController _dataGridController = DataGridController();
  final int _rowsPerPage = 10;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<PartsCubit, PartsState>(
      builder: (context, state) {
        final engines =
            state.parts
                .firstWhere((part) => part.id == state.currentPartEnginesId)
                .engines;
        if (engines.isEmpty) {
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
                  'No engines associated with this part',
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
        final engineColumns = [
          SelectionColumnConfig<EngineEntity>(
            idExtractor: (engine) => engine.id.toString(),
            selectedIds: state.selectedEngineIds,
            onToggleSelection: context.read<PartsCubit>().toggleEngineSelection,
          ),
          ColumnConfig<EngineEntity>(
            columnName: 'brand',
            displayName: 'Brand',
            valueExtractor: (engine) => engine.engineBrand.brand,
          ),
          ColumnConfig<EngineEntity>(
            columnName: 'capacity',
            displayName: 'Capacity',
            valueExtractor:
                (engine) => engine.engineCapacity.capacity.toString(),
          ),
        ];

        // Then create your data source
        final dataSource = CustomDataSource<EngineEntity>(
          data: engines,
          columns: engineColumns,
        );

        // Calculate total pages
        final int totalPages = (engines.length / _rowsPerPage).ceil();

        // Ensure current page is valid
        if (_currentPage >= totalPages && totalPages > 0) {
          _currentPage = totalPages - 1;
        }

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
                pageCount: (engines.length / _rowsPerPage).ceil().toDouble(),
              ),
            ),
          ],
        );
      },
    );
  }
}

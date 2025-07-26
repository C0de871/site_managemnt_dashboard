import 'dart:developer';

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
    this.isGeneratorsAndEngineScreen = false,
    required this.emptyMessage,
    required this.showSiteColumn,
    required this.selectedGeneratorIds,
    required this.generators,
    required this.onToggleSelection,
  });

  final bool isEmpty;
  final bool isGeneratorsAndEngineScreen;
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
  final int _rowsPerPage = 20;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<GeneratorsEnginesCubit>();

    final generatorColumns = [
      SelectionColumnConfig<GeneratorEntity>(
        idExtractor: (generator) => generator.id.toString(),
        selectedIds: widget.selectedGeneratorIds,
        onToggleSelection: widget.onToggleSelection,
      ),
      ColumnConfig<GeneratorEntity>(
        columnName: 'brand',
        displayName: 'Brand',
        valueExtractor: (generator) => generator.brand?.brand ?? "غير معروف",
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
      // ActionsColumnConfig(
      //   actions: [
      //     ActionButton<GeneratorEntity>(
      //       icon: Icons.edit,
      //       tooltip: 'Edit',
      //       onPressed: (generator) {
      //         cubit.showGeneratorDialog(context, generator: generator);
      //       },
      //       color: colorScheme.primary,
      //     ),
      //     ActionButton<GeneratorEntity>(
      //       icon: Icons.delete,
      //       tooltip: 'Delete',
      //       onPressed: (generator) {},
      //       color: colorScheme.error,
      //     ),
      //   ],
      // ),
    ];

    // Then create your data source
    final dataSource = CustomDataSource<GeneratorEntity>(
      data: widget.generators,
      columns: generatorColumns,
    );

    // Calculate total pages
    int totalPages =
        ((cubit.state.pagination?.totalItemsCount ?? 1) / _rowsPerPage).ceil();
    totalPages = totalPages == 0 ? 1 : totalPages;

    // Ensure current page is valid
    if (_currentPage >= totalPages && totalPages > 0) {
      _currentPage = totalPages - 1;
    }

    return BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
      builder: (context, state) {
        return Stack(
          children: [
            if (widget.generators.isEmpty && !state.generatorsStatus.isLoading)
              NotFoundWidget(message: widget.emptyMessage),

            if (state.generatorsStatus.isLoading)
              Container(
                height: 600,
                width: double.infinity,
                color: Colors.grey.withValues(alpha: 200),
                child: Center(child: CircularProgressIndicator()),
              ),

            IgnorePointer(
              ignoring:
                  state.actionStatus.isLoading ||
                  state.generatorsStatus.isLoading,
              child: Column(
                children: [
                  SizedBox(
                    height: 600,
                    child: SfDataGrid(
                      onQueryRowHeight: (details) {
                        return details.getIntrinsicRowHeight(details.rowIndex);
                      },
                      source: dataSource,
                      controller: _dataGridController,
                      allowSorting: true,
                      selectionMode: SelectionMode.multiple,
                      navigationMode: GridNavigationMode.cell,
                      frozenColumnsCount: 1,
                      highlightRowOnHover: true,
                      rowsPerPage:
                          widget.isGeneratorsAndEngineScreen
                              ? _rowsPerPage
                              : null,
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      columnWidthMode: ColumnWidthMode.fill,
                      columns: dataSource.getGridColumns(),
                    ),
                  ),
                  if (widget.isGeneratorsAndEngineScreen)
                    SfDataPager(
                      delegate: dataSource,
                      pageCount: totalPages.toDouble(),
                      onPageNavigationEnd: (page) {
                        int newPage = page + 1;
                        cubit.fetchGenerators(page: newPage);
                      },
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

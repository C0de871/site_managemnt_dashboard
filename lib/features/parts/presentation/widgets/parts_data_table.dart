import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/shared/widgets/my_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/shared/widgets/not_found_widget.dart';
import '../../domain/entities/part_entity.dart';
import '../cubit/parts_cubit.dart';

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

    return BlocBuilder<PartsCubit, PartsState>(
      builder: (context, state) {
        final partColumns = [
          SelectionColumnConfig<PartEntity>(
            idExtractor: (part) => part.id.toString(),
            selectedIds: state.selectedPartIds,
            onToggleSelection: context.read<PartsCubit>().togglePartSelection,
          ),
          ColumnConfig<PartEntity>(
            columnName: 'code',
            displayName: 'Part Code',
            valueExtractor: (part) => part.code ?? "غير معروف",
          ),
          ColumnConfig<PartEntity>(
            columnName: 'name',
            displayName: 'Part Name',
            valueExtractor: (part) => part.name,
          ),

          ColumnConfig<PartEntity>(
            columnName: 'isPrimary',
            displayName: 'primary ',
            valueExtractor: (part) => part.isPrimary ? 'Yes' : 'No',
          ),
          ColumnConfig<PartEntity>(
            columnName: 'isGeneral',
            displayName: 'Is General',
            valueExtractor: (part) => part.isGeneral! ? 'Yes' : 'No',
          ),
          ActionsColumnConfig<PartEntity>(
            actions: [
              ActionButton<PartEntity>(
                icon: Icons.visibility,
                tooltip: 'View ',
                color: colorScheme.onSurface,
                onPressed:
                    (part) => context
                        .read<PartsCubit>()
                        .setCurrentPartEnginesId(part.id),
              ),
              ActionButton<PartEntity>(
                icon: Icons.edit,
                tooltip: 'edit ',
                color: colorScheme.primary,
                onPressed:
                    (part) => context.read<PartsCubit>().showAddEditPartDialog(
                      context,
                      part,
                    ),
              ),
              // ActionButton<PartEntity>(
              //   icon: Icons.delete,
              //   tooltip: 'delete ',
              //   color: colorScheme.error,
              //   onPressed:
              //       (report) => context
              //           .read<PartsCubit>()
              //           .setCurrentPartEnginesId(report.id),
              // ),
            ],
          ),
        ];

        // Then create your data source
        final dataSource = CustomDataSource<PartEntity>(
          data: state.parts,
          columns: partColumns,
        );

        // Calculate total pages
        int totalPages =
            ((state.pagination.totalItemsCount ?? 1) / _rowsPerPage).ceil();
        totalPages = totalPages == 0 ? 1 : totalPages;
        // Ensure current page is valid
        if (_currentPage >= totalPages && totalPages > 0) {
          _currentPage = totalPages - 1;
        }

        return Stack(
          children: [
            if (state.parts.isEmpty && !state.partsStatus.isLoading)
              Positioned.fill(child: NotFoundWidget(message: "No parts found")),

            if (state.partsStatus.isLoading || state.actionStatus.isLoading)
              Container(
                height: 600,
                width: double.infinity,
                color: Colors.grey.withValues(alpha: 200),
                child: Center(child: CircularProgressIndicator()),
              ),

            IgnorePointer(
              ignoring:
                  state.partsStatus.isLoading || state.actionStatus.isLoading,
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
                      pageCount: totalPages.toDouble(),
                      onPageNavigationEnd: (page) {
                        context.read<PartsCubit>().searchParts(page: page + 1);
                      },
                    ),
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

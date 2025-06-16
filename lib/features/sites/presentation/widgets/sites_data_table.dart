import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/shared/widgets/my_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../domain/entities/sites_entity.dart';
import '../cubit/sites_cubit.dart';

class SitesDataTable extends StatefulWidget {
  const SitesDataTable({super.key});

  @override
  State<SitesDataTable> createState() => _SitesDataTableState();
}

class _SitesDataTableState extends State<SitesDataTable> {
  final DataGridController _dataGridController = DataGridController();
  final int _rowsPerPage = 20;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final sitesCubit = context.read<SitesCubit>();

    return BlocBuilder<SitesCubit, SitesState>(
      builder: (context, state) {
        if (state.sitesResponseEntity?.sites.isEmpty ?? false) {
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
                  'No sites found',
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

        final siteColumns = [
          SelectionColumnConfig<SiteEntity>(
            idExtractor: (site) => site.id.toString(),
            selectedIds: state.selectedSiteIds,
            onToggleSelection: context.read<SitesCubit>().toggleSiteSelection,
          ),
          ColumnConfig<SiteEntity>(
            columnName: 'code',
            displayName: 'Site Code',
            valueExtractor: (site) => site.code,
          ),
          ColumnConfig<SiteEntity>(
            columnName: 'name',
            displayName: 'Site Name',
            valueExtractor: (site) => site.name,
          ),
          ColumnConfig<SiteEntity>(
            columnName: 'longitude',
            displayName: 'Longitude',
            valueExtractor: (site) => site.longitude ?? "Unkown",
            visible: false,
          ),
          ColumnConfig<SiteEntity>(
            columnName: 'latitude',
            displayName: 'Latitude',
            valueExtractor: (site) => site.latitude ?? "Unkown",
            visible: false,
          ),
          ActionsColumnConfig<SiteEntity>(
            actions: [
              ActionButton<SiteEntity>(
                icon: Icons.visibility,
                tooltip: 'View Generators',
                onPressed:
                    (site) => context
                        .read<SitesCubit>()
                        .setCurrentSiteGeneratorsId(site.id),
                color: colorScheme.onSurface,
              ),
              ActionButton<SiteEntity>(
                icon: Icons.edit,
                tooltip: 'Edit',
                onPressed: (site) {
                  log(site.toString());
                  context.read<SitesCubit>().showAddEditSiteDialog(
                    context,
                    state.sitesResponseEntity?.sites.indexOf(site),
                  );
                },
                color: colorScheme.primary,
              ),
              ActionButton<SiteEntity>(
                icon: Icons.delete,
                tooltip: 'Delete',
                onPressed:
                    (site) => context
                        .read<SitesCubit>()
                        .setCurrentSiteGeneratorsId(site.id),
                color: colorScheme.error,
              ),
            ],
          ),
        ];

        // Then create your data source
        final dataSource = CustomDataSource<SiteEntity>(
          data: state.sitesResponseEntity?.sites ?? [],
          columns: siteColumns,
        );

        // Calculate total pages
        log("${state.sitesResponseEntity?.pagination.totalItemsCount}");
        final int totalPages =
            (state.sitesResponseEntity?.pagination.totalItemsCount ?? 1);

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
                pageCount: totalPages.toDouble(),
                onPageNavigationStart: (pageNumber) {
                  sitesCubit.fetchSites(page: pageNumber);
                },
                onPageNavigationEnd: (pageNumber) {},
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/shared/widgets/my_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/shared/widgets/not_found_widget.dart';
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
    log("rebuild the sites data table widget");

    return BlocBuilder<SitesCubit, SitesState>(
      builder: (context, state) {
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
              // ActionButton<SiteEntity>(
              //   icon: Icons.delete,
              //   tooltip: 'Delete',
              //   onPressed:
              //       (site) => context
              //           .read<SitesCubit>()
              //           .setCurrentSiteGeneratorsId(site.id),
              //   color: colorScheme.error,
              // ),
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
        int totalPages =
            ((state.sitesResponseEntity?.pagination.totalItemsCount ?? 1) /
                    _rowsPerPage)
                .ceil();
        totalPages = totalPages == 0 ? 1 : totalPages;

        // Ensure current page is valid
        if (_currentPage >= totalPages && totalPages > 0) {
          _currentPage = totalPages - 1;
        }

        log("sitestatus is: ${state.sitesStatus.isLoading}");
        log("site action status is: ${state.actionStatus.isLoading}");

        return Stack(
          children: [
            if ((state.sitesResponseEntity?.sites.isEmpty ?? false))
              NotFoundWidget(message: "No sites found"),

            if (state.sitesStatus.isLoading || state.actionStatus.isLoading)
              Container(
                height: 600,
                width: double.infinity,
                color: Colors.grey.withValues(alpha: 200),
                child: Center(child: CircularProgressIndicator()),
              ),

            // if (state.sitesResponseEntity?.sites.isNotEmpty ?? false)
            IgnorePointer(
              ignoring:
                  state.sitesStatus.isLoading || state.actionStatus.isLoading,
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
                      initialPageIndex: 1,
                      onPageNavigationStart: (pageNumber) {},
                      onPageNavigationEnd: (pageNumber) {
                        log("page number: $pageNumber");
                        sitesCubit.searchSites(page: pageNumber + 1);
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

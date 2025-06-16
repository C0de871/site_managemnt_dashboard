import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generators/presentation/widgets/generators_data_table.dart';
import '../../../generators/presentation/widgets/generators_filter_bar.dart';
import '../cubit/sites_cubit.dart';
import 'site_generators_filer_bar.dart';
// import 'generators_filter.dart';

class RightTable extends StatelessWidget {
  const RightTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SitesCubit, SitesState>(
      builder: (context, state) {
        log("right table generators${state.generatorStatus.toString()}");
        log(
          "right table currentSiteGeneratorsId${state.currentSiteGeneratorsId.toString()}",
        );

        return state.generatorStatus.isLoaded &&
                state.currentSiteGeneratorsId != -1
            ? Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SiteGeneratorsFilterBar(),
                  Expanded(
                    child: GeneratorsDataTable(
                      isEmpty:
                          state.sitesResponseEntity?.sites
                              .firstWhere(
                                (site) =>
                                    site.id == state.currentSiteGeneratorsId,
                              )
                              .generators
                              ?.isEmpty ??
                          true,
                      showSiteColumn: false,
                      selectedGeneratorIds: state.selectedGeneratorIds,
                      generators:
                          state.sitesResponseEntity?.sites
                              .firstWhere(
                                (site) =>
                                    site.id == state.currentSiteGeneratorsId,
                              )
                              .generators ??
                          [],
                      onToggleSelection:
                          context.read<SitesCubit>().toggleGeneratorSelection,
                      emptyMessage: 'No generators found',
                    ),
                  ),
                ],
              ),
            )
            : const SizedBox.shrink();
      },
    );
  }
}

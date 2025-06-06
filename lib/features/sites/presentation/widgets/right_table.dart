import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generators/presentation/widgets/generators_data_table.dart';
import '../cubit/sites_cubit.dart';
import 'generators_filter.dart';

class RightTable extends StatelessWidget {
  const RightTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SitesCubit, SitesState>(
      builder: (context, state) {
        return state.generatorStatus.isLoaded &&
                state.currentSiteGeneratorsId != null
            ? Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // GeneratorsFilterBar(),
                  Expanded(
                    child: GeneratorsDataTable(
                      isEmpty:
                          state
                              .sites[state.currentSiteGeneratorsId!]
                              .generators
                              ?.isEmpty ??
                          true,
                      showSiteColumn: false,
                      selectedGeneratorIds: state.selectedGeneratorIds,
                      generators:
                          state
                              .sites[state.currentSiteGeneratorsId!]
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

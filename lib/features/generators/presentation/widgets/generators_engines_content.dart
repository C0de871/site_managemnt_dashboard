import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/cubit/generators_cubit.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/widgets/engine_capacities_section.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/widgets/engines_section.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/widgets/generator_brands_section.dart';

import '../../domain/entities/generator_entity.dart';
import 'engine_brands_section.dart';
import 'generators_data_table.dart';
import 'generators_filter_bar.dart';

class GeneratorsEnginesContent extends StatelessWidget {
  const GeneratorsEnginesContent({super.key, required this.generators});
  final List<GeneratorEntity> generators;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GeneratorsFilterBar(),
            BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
              builder: (context, state) {
                return GeneratorsDataTable(
                  isEmpty: state.generators.isEmpty,
                  emptyMessage: 'No generators found',
                  showSiteColumn: true,
                  selectedGeneratorIds: state.selectedGeneratorIds,
                  generators: state.generators,
                  onToggleSelection:
                      context
                          .read<GeneratorsEnginesCubit>()
                          .toggleGeneratorSelection,
                );
              },
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: EngineBrandsSection()),
                const SizedBox(width: 24),
                Expanded(child: GeneratorBrandsSection()),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: EngineCapacitiesSection()),
                const SizedBox(width: 24),
                Expanded(child: EnginesSection()),
              ],
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

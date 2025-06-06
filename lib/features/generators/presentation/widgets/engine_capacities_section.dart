import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/cubit/generators_cubit.dart';

import '../../../../core/utils/services/dialog_launcher.dart';
import 'capacities_list.dart';
import 'management_section.dart';

class EngineCapacitiesSection extends StatelessWidget {
  const EngineCapacitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ManagementSection(
      title: 'Engine Capacities',
      icon: Icons.speed,
      child: BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
        buildWhen:
            (previous, current) =>
                previous.engineCapacitiesStatus !=
                    current.engineCapacitiesStatus ||
                previous.engineCapacities != current.engineCapacities,
        builder: (context, state) {
          if (state.engineCapacitiesStatus.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return CapacitiesList(
            capacities: state.engineCapacities,
            onAdd:
                () => context.read<GeneratorsEnginesCubit>().showCapacityDialog(
                  context,
                ),
            onEdit:
                (capacity) => context
                    .read<GeneratorsEnginesCubit>()
                    .showCapacityDialog(context, capacity: capacity),
            onDelete:
                (capacity) => DialogLauncher.showConfirmDeleteDialog(
                  context,
                  title: 'Delete Engine Capacity',
                  content:
                      'Are you sure you want to delete capacity "${capacity.capacity} kW"?',
                  onConfirm:
                      () => context
                          .read<GeneratorsEnginesCubit>()
                          .deleteEngineCapacity(capacity.id),
                ),
          );
        },
      ),
    );
  }
}

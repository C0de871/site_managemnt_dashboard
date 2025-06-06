import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/cubit/generators_cubit.dart';

import '../../../../core/utils/services/dialog_launcher.dart';
import 'engines_list.dart';
import 'management_section.dart';

class EnginesSection extends StatelessWidget {
  const EnginesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GeneratorsEnginesCubit>();
    return ManagementSection(
      title: 'Available Engines',
      icon: Icons.settings,
      child: BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
        buildWhen:
            (previous, current) =>
                previous.enginesStatus != current.enginesStatus ||
                previous.engines != current.engines,
        builder: (context, state) {
          if (state.enginesStatus.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return EnginesList(
            engines: state.engines,
            onAdd: () => cubit.showEngineDialog(context),
            onEdit: (engine) => cubit.showEngineDialog(context, engine: engine),
            onDelete:
                (engine) => DialogLauncher.showConfirmDeleteDialog(
                  context,
                  title: 'Delete Engine',
                  content: 'Are you sure you want to delete this engine?',
                  onConfirm:
                      () => context.read<GeneratorsEnginesCubit>().deleteEngine(
                        engine.id,
                      ),
                ),
          );
        },
      ),
    );
  }
}

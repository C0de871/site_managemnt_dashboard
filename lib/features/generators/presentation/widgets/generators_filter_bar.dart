import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../reports/presentation/screens/widgets/search_field.dart';
import '../cubit/generators_cubit.dart';
import 'generators_action_buttons.dart';

class GeneratorsFilterBar extends StatelessWidget {
  const GeneratorsFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<GeneratorsEnginesCubit>();
    return Container(
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
        builder: (context, state) {
          return Row(
            children: [
              GeneratorsActionButtons(),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: SearchField(
                  hintText: "Search Generators...",
                  controller: cubit.searchGeneratorsController,
                  onPressed: cubit.searchGenerators,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

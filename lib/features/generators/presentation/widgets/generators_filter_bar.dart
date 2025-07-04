import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/generators_cubit.dart';
import 'generators_action_buttons.dart';

class GeneratorsFilterBar extends StatelessWidget {
  const GeneratorsFilterBar({super.key, });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
      child: Row(
        children: [
          BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
            builder: (context, state) {
              if (state.generatorsStatus.isLoaded) {
                log("generators is loaded ");
                return GeneratorsActionButtons();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

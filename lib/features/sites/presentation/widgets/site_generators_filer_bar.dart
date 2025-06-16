import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/sites/presentation/cubit/sites_cubit.dart';
import 'package:site_managemnt_dashboard/features/sites/presentation/widgets/site_generators_action_buttons.dart';

class SiteGeneratorsFilterBar extends StatelessWidget {
  const SiteGeneratorsFilterBar({super.key});

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
          BlocBuilder<SitesCubit, SitesState>(
            builder: (context, state) {
              if (state.generatorStatus.isLoaded) {
                log("generators is loaded ");
                return SiteGeneratorsActionButtons();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

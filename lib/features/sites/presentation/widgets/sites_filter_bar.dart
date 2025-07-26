import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../reports/presentation/screens/widgets/search_field.dart';
import '../cubit/sites_cubit.dart';
import 'sites_action_buttons.dart';

class SitesFilterBar extends StatelessWidget {
  const SitesFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<SitesCubit>();

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
      child: BlocBuilder<SitesCubit, SitesState>(
        builder: (context, state) {
          return Row(
            children: [
              const SitesActionButtons(),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: SearchField(
                  hintText: "Search Sites...",
                  controller: cubit.searchController,
                  onPressed: cubit.searchSites,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../reports/presentation/screens/widgets/search_field.dart';
import '../cubit/parts_cubit.dart';
import 'parts_action_buttons.dart';

class PartsFilterBar extends StatelessWidget {
  const PartsFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<PartsCubit>();

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
      child: BlocBuilder<PartsCubit, PartsState>(
        builder: (context, state) {
          return Row(
            children: [
              const PartsActionButtons(),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: SearchField(
                  hintText: "Search Parts by code...",
                  controller: cubit.searchController,
                  onPressed: cubit.searchParts,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/reports/presentation/cubits/reports_cubit.dart';

import 'reports_search_field.dart';
import 'visit_type_filter.dart';
import 'reports_action_buttons.dart';

class ReportsFilterBar extends StatelessWidget {
  const ReportsFilterBar({super.key});

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
          // // Search Field
          // const Expanded(flex: 3, child: ReportsSearchField()),

          // const SizedBox(width: 16),

          // // Visit Type Filter
          // BlocBuilder<ReportsCubit, ReportsState>(
          //   builder: (context, state) {
          //     if (state is ReportsLoaded) {
          //       return const Expanded(flex: 2, child: VisitTypeFilter());
          //     }
          //     return const SizedBox.shrink();
          //   },
          // ),

          // const SizedBox(width: 16),

          // Action Buttons
          BlocBuilder<ReportsCubit, ReportsState>(
            builder: (context, state) {
              if (state is ReportsLoaded) {
                return const ReportsActionButtons();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

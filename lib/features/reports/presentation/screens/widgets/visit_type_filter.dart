import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/report_entity.dart';
import '../../cubits/reports_cubit.dart';

class VisitTypeFilter extends StatelessWidget {
  const VisitTypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        final cubit = context.read<ReportsCubit>();

        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<VisitType?>(
              isExpanded: true,
              value: cubit.selectedVisitType,
              hint: Text(
                'Filter by Visit Type',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
              icon: Icon(
                Icons.filter_list,
                color: colorScheme.onSurfaceVariant,
              ),
              items: [
                DropdownMenuItem<VisitType?>(
                  value: null,
                  child: Text(
                    'All Visit Types',
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                ),
                ...VisitType.values.map((type) {
                  return DropdownMenuItem<VisitType>(
                    value: type,
                    child: Text(
                      type.arabicName,
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                  );
                }),
              ],
              onChanged: cubit.setVisitType,
            ),
          ),
        );
      },
    );
  }
}

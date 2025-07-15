import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/custom_input_text_field.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/info_card.dart';

import '../cubit/report_details_cubit.dart';

class CompletedWorksCard extends StatelessWidget {
  const CompletedWorksCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportDetailsCubit>();
    return InfoCard(
      title: "Completed Works",
      width: double.infinity,
      height: 340,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(cubit.completedTasksControllers.length, (
              index,
            ) {
              return CustomInputTextField(
                labelText: "$index-th task",
                controller: cubit.completedTasksControllers[index],
              );
            }),
          ),
        ),
      ),
    );
  }
}

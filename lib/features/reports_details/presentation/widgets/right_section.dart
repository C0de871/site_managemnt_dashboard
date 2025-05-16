import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/completed_works_card.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/generator_card.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/voltages_and_load_card.dart';

import '../cubit/report_details_cubit.dart';

class RightSection extends StatelessWidget {
  const RightSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportDetailsCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneratorCard(cubit: cubit),
        SizedBox(height: 32),
        VoltagesAndLoadCard(cubit: cubit),
        SizedBox(height: 32),
        CompletedWorksCard(),
      ],
    );
  }
}

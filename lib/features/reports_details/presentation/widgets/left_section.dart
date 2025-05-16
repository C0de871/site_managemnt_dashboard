import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/battery_and_oil_card.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/general_info_card.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/location_card.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/others_card.dart';

import '../cubit/report_details_cubit.dart';

class LeftSection extends StatelessWidget {
  const LeftSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportDetailsCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralInfoCard(cubit: cubit),
        SizedBox(height: 32),
        BatteryAndOilCard(cubit: cubit),
        SizedBox(height: 32),
        OthersCard(cubit: cubit),
        SizedBox(height: 32),
        LocationCard(cubit: cubit),
      ],
    );
  }
}

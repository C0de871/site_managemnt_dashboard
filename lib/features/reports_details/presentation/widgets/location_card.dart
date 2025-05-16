import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/cubit/report_details_cubit.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/custom_input_text_field.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/info_card.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key, required this.cubit});

  final ReportDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "Location",
      width: double.infinity,
      child: CustomInputTextField(
        labelText: "Site location",
        controller: cubit.siteLocationController,
      ),
    );
  }
}

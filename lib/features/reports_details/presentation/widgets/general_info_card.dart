import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/cubit/report_details_cubit.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/custom_input_text_field.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/info_card.dart';

class GeneralInfoCard extends StatelessWidget {
  const GeneralInfoCard({super.key, required this.cubit});

  final ReportDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "General Information",
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputTextField(
                  labelText: "Site name",
                  controller: cubit.siteNameController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Site code",
                  controller: cubit.siteCodeController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Report number",
                  controller: cubit.reportNumberController,
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputTextField(
                  labelText: "Visit type",
                  controller: cubit.visitTypeController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Visit date",
                  controller: cubit.visitDateController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Visit time",
                  controller: cubit.visitTimeController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

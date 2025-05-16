import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/cubit/report_details_cubit.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/custom_input_text_field.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/info_card.dart';

class OthersCard extends StatelessWidget {
  const OthersCard({super.key, required this.cubit});

  final ReportDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "Ohter Information",
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomInputTextField(
                  labelText: "Visit reasons",
                  controller: cubit.visitResonsController,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: CustomInputTextField(
                  labelText: "Technical condition",
                  controller: cubit.technicalConditionController,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          CustomInputTextField(
            labelText: "Technician notes",
            controller: cubit.technicianNotesController,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/cubit/report_details_cubit.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/custom_input_text_field.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/info_card.dart';

class GeneratorCard extends StatelessWidget {
  const GeneratorCard({
    super.key,
    required this.cubit,
  });

  final ReportDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "Generator Information",
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                CustomInputTextField(
                  labelText: "Generator brand",
                  controller: cubit.generatorBrandController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Engine brand",
                  controller: cubit.engineBrandController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Engine capacity",
                  controller: cubit.engineCapacityController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Counter reading",
                  controller: cubit.counterReadingController,
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                CustomInputTextField(
                  labelText: "Last counter reading",
                  controller: cubit.lastCounterReadingController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Cables status",
                  controller: cubit.cablesStatusController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Last visit date",
                  controller: cubit.lastVisitDateController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

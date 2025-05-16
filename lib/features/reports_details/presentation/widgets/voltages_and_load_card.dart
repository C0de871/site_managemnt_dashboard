import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/cubit/report_details_cubit.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/custom_input_text_field.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/info_card.dart';

class VoltagesAndLoadCard extends StatelessWidget {
  const VoltagesAndLoadCard({
    super.key,
    required this.cubit,
  });

  final ReportDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "voltages",
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                CustomInputTextField(
                  labelText: "Voltage 1",
                  controller: cubit.batteryVoltage1Controller,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Voltage 2",
                  controller: cubit.batteryVoltage2Controller,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Voltage 3",
                  controller: cubit.batteryVoltage3Controller,
                ),
              ],
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                CustomInputTextField(
                  labelText: "Load 1",
                  controller: cubit.batteryLoad1Controller,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Load 2",
                  controller: cubit.batteryLoad2Controller,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Load 3",
                  controller: cubit.batteryLoad3Controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

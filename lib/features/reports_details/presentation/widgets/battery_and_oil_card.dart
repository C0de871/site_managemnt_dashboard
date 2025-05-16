import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/cubit/report_details_cubit.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/custom_input_text_field.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/info_card.dart';

class BatteryAndOilCard extends StatelessWidget {
  const BatteryAndOilCard({super.key, required this.cubit});

  final ReportDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "Battery & Oil",
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
                  labelText: "Temperature",
                  controller: cubit.temperatureController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Oil pressure",
                  controller: cubit.oilPressureController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Battery voltage",
                  controller: cubit.batteryVoltageController,
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
                  labelText: "Burned oil quantity",
                  controller: cubit.burnedOilQuantityController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Frequency",
                  controller: cubit.frequencyController,
                ),
                SizedBox(height: 12),
                CustomInputTextField(
                  labelText: "Oil quantity",
                  controller: cubit.oilQuantityController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

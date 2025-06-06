import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/reports/presentation/screens/widgets/reports_data_table.dart';
import 'package:site_managemnt_dashboard/features/reports/presentation/screens/widgets/reports_filter_bar.dart';

import '../../../domain/entities/report_entity.dart';

class ReportsContent extends StatelessWidget {
  const ReportsContent({super.key, required this.filteredReports});
  final List<ReportEntity> filteredReports;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [ReportsFilterBar(), Expanded(child: ReportsDataTable())],
      ),
    );
  }
}

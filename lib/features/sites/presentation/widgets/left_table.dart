import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/sites/presentation/widgets/sites_data_table.dart';
import 'package:site_managemnt_dashboard/features/sites/presentation/widgets/sites_filter_bar.dart';

class LeftTable extends StatelessWidget {
  const LeftTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [SitesFilterBar(), Expanded(child: SitesDataTable())],
      ),
    );
  }
}

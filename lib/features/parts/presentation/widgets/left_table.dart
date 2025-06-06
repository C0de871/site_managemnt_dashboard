import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/parts/presentation/widgets/parts_data_table.dart';
import 'package:site_managemnt_dashboard/features/parts/presentation/widgets/parts_filter_bar.dart';

class LeftTable extends StatelessWidget {
  const LeftTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [PartsFilterBar(), Expanded(child: PartsDataTable())],
      ),
    );
  }
}

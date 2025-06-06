import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/parts/presentation/widgets/left_table.dart';
import 'package:site_managemnt_dashboard/features/parts/presentation/widgets/right_table.dart';

import '../../domain/entities/part_entity.dart';

class PartsContent extends StatelessWidget {
  const PartsContent({super.key, required this.parts});
  final List<PartEntity> parts;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Row(children: [LeftTable(), SizedBox(width: 32), RightTable()]),
    );
  }
}

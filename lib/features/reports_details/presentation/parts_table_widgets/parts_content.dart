import 'package:flutter/material.dart';

import '../../../parts/domain/entities/part_entity.dart';
import 'left_table.dart';
import 'parts_data_table.dart';

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
      child: PartsDataTable(),
    );
  }
}

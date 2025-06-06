import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/engine_capacities/domain/entities/engine_capacity_entity.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/widgets/brand_card.dart';

import 'add_button.dart';

class CapacitiesList extends StatelessWidget {
  final List<EngineCapacityEntity> capacities;
  final VoidCallback onAdd;
  final Function(EngineCapacityEntity) onEdit;
  final Function(EngineCapacityEntity) onDelete;

  const CapacitiesList({
    super.key,
    required this.capacities,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: capacities.length,
            itemBuilder:
                (context, index) => DefaultItemCard(
                  title: "${capacities[index].capacity.toString()} kW",
                  onEdit: () => onEdit(capacities[index]),
                  onDelete: () => onDelete(capacities[index]),
                ),
          ),
        ),
        const SizedBox(height: 16),
        AddButton(onPressed: onAdd),
      ],
    );
  }
}

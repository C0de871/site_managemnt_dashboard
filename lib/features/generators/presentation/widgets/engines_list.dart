import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/engines/domain/entities/engine_entity.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/widgets/brand_card.dart';

import 'add_button.dart';

class EnginesList extends StatelessWidget {
  final List<EngineEntity> engines;
  final VoidCallback onAdd;
  final Function(EngineEntity) onEdit;
  final Function(EngineEntity) onDelete;

  const EnginesList({
    super.key,
    required this.engines,
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
            primary: true,
            itemCount: engines.length,
            itemBuilder: (context, index) {
              final engine = engines[index];
              return DefaultItemCard(
                title: engine.engineBrand.brand,
                description: "${engine.engineCapacity.capacity.toString()} kW",
                onEdit: () => onEdit(engine),
                onDelete: () => onDelete(engine),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        AddButton(onPressed: onAdd),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../engine_capacities/domain/entities/engine_capacity_entity.dart';
import '../cubit/generators_cubit.dart';

class CapacityDialog extends StatelessWidget {
  const CapacityDialog({
    super.key,
    required this.capacity,
    required this.cubit,
  });

  final EngineCapacityEntity? capacity;
  final GeneratorsEnginesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        capacity == null ? 'Add Engine Capacity' : 'Edit Engine Capacity',
      ),
      content: TextField(
        controller: cubit.capacityController,
        decoration: InputDecoration(labelText: 'Capacity (kW)'),
        keyboardType: TextInputType.number,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final capacityValue = int.tryParse(
              cubit.capacityController.text.trim(),
            );
            if (capacityValue != null && capacityValue > 0) {
              if (capacity == null) {
                cubit.addEngineCapacity(capacityValue);
              } else {
                cubit.updateEngineCapacity(capacity!.id, capacityValue);
              }
              Navigator.of(context).pop();
            }
          },
          child: Text(capacity == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}

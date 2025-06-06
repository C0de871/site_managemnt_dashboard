import 'package:flutter/material.dart';

import '../../../engines/domain/entities/engine_entity.dart';
import '../cubit/generators_cubit.dart';

class EngineDialog extends StatelessWidget {
  const EngineDialog({
    super.key,
    required this.engine,
    required this.cubit,
    required this.state,
  });

  final EngineEntity? engine;
  final GeneratorsEnginesCubit cubit;
  final GeneratorsEnginesState state;

  @override
  Widget build(BuildContext context) {
    int? selectedBrandId = engine?.engineBrand.id;
    int? selectedCapacityId = engine?.engineCapacity.id;

    return StatefulBuilder(
      builder:
          (context, setState) => AlertDialog(
            title: Text(engine == null ? 'Add Engine' : 'Edit Engine'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                  value: selectedBrandId,
                  decoration: InputDecoration(labelText: 'Engine Brand'),
                  items:
                      state.engineBrands
                          .map(
                            (brand) => DropdownMenuItem(
                              value: brand.id,
                              child: Text(brand.brand),
                            ),
                          )
                          .toList(),
                  onChanged: (value) => setState(() => selectedBrandId = value),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: selectedCapacityId,
                  decoration: InputDecoration(labelText: 'Engine Capacity'),
                  items:
                      state.engineCapacities
                          .map(
                            (capacity) => DropdownMenuItem(
                              value: capacity.id,
                              child: Text('${capacity.capacity} kW'),
                            ),
                          )
                          .toList(),
                  onChanged:
                      (value) => setState(() => selectedCapacityId = value),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedBrandId != null && selectedCapacityId != null) {
                    if (engine == null) {
                      cubit.addEngine(selectedBrandId!, selectedCapacityId!);
                    } else {
                      cubit.updateEngine(
                        engine!.id,
                        selectedBrandId!,
                        selectedCapacityId!,
                      );
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text(engine == null ? 'Add' : 'Update'),
              ),
            ],
          ),
    );
  }
}

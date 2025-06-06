import 'package:flutter/material.dart';

import '../../../engine_brands/domain/entities/brand_entity.dart';
import '../cubit/generators_cubit.dart';

class BrandDialog extends StatelessWidget {
  const BrandDialog({
    super.key,
    required this.brand,
    required this.isEngine,
    required this.cubit,
  });

  final BrandEntity? brand;
  final bool isEngine;
  final GeneratorsEnginesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        brand == null
            ? 'Add ${isEngine ? 'Engine' : 'Generator'} Brand'
            : 'Edit ${isEngine ? 'Engine' : 'Generator'} Brand',
      ),
      content: TextField(
        controller: cubit.brandController,
        decoration: InputDecoration(labelText: 'Brand Name'),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (cubit.brandController.text.trim().isNotEmpty) {
              if (brand == null) {
                if (isEngine) {
                  cubit.addEngineBrand(cubit.brandController.text.trim());
                } else {
                  cubit.addGeneratorBrand(cubit.brandController.text.trim());
                }
              } else {
                if (isEngine) {
                  cubit.updateEngineBrand(
                    brand!.id,
                    cubit.brandController.text.trim(),
                  );
                } else {
                  cubit.updateGeneratorBrand(
                    brand!.id,
                    cubit.brandController.text.trim(),
                  );
                }
              }
              Navigator.of(context).pop();
            }
          },
          child: Text(brand == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}

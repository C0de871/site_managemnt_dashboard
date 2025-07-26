import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/engine_brands/domain/entities/brand_entity.dart';

import 'add_button.dart';
import 'brand_card.dart';

class BrandsList extends StatelessWidget {
  final List<BrandEntity> brands;
  final VoidCallback onAdd;
  final Function(BrandEntity) onEdit;
  final Function(BrandEntity) onDelete;

  const BrandsList({
    super.key,
    required this.brands,
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
            itemCount: brands.length,
            itemBuilder:
                (context, index) => DefaultItemCard(
                  title: brands[index].brand,
                  onEdit: () => onEdit(brands[index]),
                  onDelete: () => onDelete(brands[index]),
                ),
          ),
        ),
        const SizedBox(height: 16),
        AddButton(onPressed: onAdd),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/engines/domain/entities/engine_entity.dart';

class EngineCard extends StatelessWidget {
  final EngineEntity engine;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EngineCard({
    super.key,
    required this.engine,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  engine.engineBrand.brand,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  '${engine.engineCapacity.capacity} kW',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: onEdit,
            tooltip: 'Edit',
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
            onPressed: onDelete,
            tooltip: 'Delete',
          ),
        ],
      ),
    );
  }
}

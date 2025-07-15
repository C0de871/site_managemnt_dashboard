import 'package:flutter/material.dart';

class DefaultItemCard extends StatelessWidget {
  final String title;
  final String? description;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DefaultItemCard({
    super.key,
    required this.title,
    required this.onEdit,
    required this.onDelete,
    this.description,
  });

  Widget buildBody(BuildContext context) {
    if (description == null) {
      return Expanded(
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
      );
    } else {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              description!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          buildBody(context),
          // IconButton(
          //   icon: Icon(
          //     Icons.edit,
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          //   onPressed: onEdit,
          //   tooltip: 'Edit',
          // ),
          // IconButton(
          //   icon: Icon(
          //     Icons.delete,
          //     color: Theme.of(context).colorScheme.error,
          //   ),
          //   onPressed: onDelete,
          //   tooltip: 'Delete',
          // ),
        ],
      ),
    );
  }
}

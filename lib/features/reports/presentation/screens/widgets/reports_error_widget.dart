import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/reports/presentation/cubits/reports_cubit.dart';

class ReportsErrorWidget extends StatelessWidget {
  const ReportsErrorWidget({
    super.key,
    required this.colorScheme,
    required this.message,
  });

  final ColorScheme colorScheme;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: colorScheme.error),
          const SizedBox(height: 16),
          Text(
            'Error loading reports',
            style: TextStyle(fontSize: 20, color: colorScheme.error),
          ),
          const SizedBox(height: 8),
          Text(message, style: TextStyle(color: colorScheme.onSurfaceVariant)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => context.read<ReportsCubit>().loadReports(),
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/reports/presentation/screens/widgets/reports_content.dart';
import 'package:site_managemnt_dashboard/features/reports/presentation/screens/widgets/reports_error_widget.dart';

import '../cubits/reports_cubit.dart';
import 'widgets/screen_header.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Screen Header
          ScreenHeader(
            title: 'Reports',
            subtitle: 'Manage your site visit reports',
            icon: Icons.summarize,
          ),

          // Main Content
          Expanded(
            child: BlocBuilder<ReportsCubit, ReportsState>(
              builder: (context, state) {
                if (state is ReportsInitial || state is ReportsLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  );
                } else if (state is ReportsError) {
                  return ReportsErrorWidget(
                    colorScheme: colorScheme,
                    message: state.message,
                  );
                } else if (state is ReportsActionInProgress) {
                  return Stack(
                    children: [
                      ReportsContent(filteredReports: state.baseState.reports),
                      Container(
                        color: Colors.black.withValues(alpha: 0.3),
                        child: Center(
                          child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 24,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    color: colorScheme.primary,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    state.action,
                                    style: TextStyle(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is ReportsLoaded) {
                  return ReportsContent(filteredReports: state.filteredReports);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

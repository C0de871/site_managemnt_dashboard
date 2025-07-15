// ignore_for_file: unnecessary_type_check

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/reports/domain/entities/report_entity.dart';
import 'package:site_managemnt_dashboard/features/reports/presentation/screens/widgets/reports_content.dart';

import '../cubits/reports_cubit.dart';
import 'widgets/screen_header.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // final reportCubit = context.read<ReportsCubit>();

    return BlocListener<ReportsCubit, ReportsState>(
      listener: (context, state) {
        // if (state is ReportsActionInProgress) {
        //   reportCubit.showLoadingDialog();
        // } else if (state is ReportsActionSuccess) {
        //   reportCubit.hideDialog();
        //   ScaffoldMessenger.of(
        //     context,
        //   ).showSnackBar(const SnackBar(content: Text('Deleted successfully')));
        // } else if (state is ReportsError) {
        //   reportCubit.showErrorDialog('Failed to delete item.');
        // }
      },
      child: Scaffold(
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
                  final List<ReportEntity> filteredReports =
                      state is ReportsState ? state.filteredReports : [];
                  // if (state is ReportsInitial || state is ReportsLoading) {
                  //   // return Center(
                  //   //   child: CircularProgressIndicator(
                  //   //     color: colorScheme.primary,
                  //   //   ),
                  //   // );
                  //   return ReportsContent(filteredReports: []);
                  // } else if (state is ReportsError) {
                  //   return MyErrorWidget(
                  //     colorScheme: colorScheme,
                  //     message: state.message,
                  //     onPressed: context.read<ReportsCubit>().loadReports,
                  //     title: 'Error loading reports',
                  //   );
                  // } else if (state is ReportsLoaded) {
                  return ReportsContent(filteredReports: filteredReports);
                  // }
                  // return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

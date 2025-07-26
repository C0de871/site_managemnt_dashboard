import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/my_error_widget.dart';
import '../../../reports/presentation/screens/widgets/screen_header.dart';
import '../cubit/report_details_cubit.dart';
import '../parts_table_widgets/parts_content.dart';
import '../widgets/left_section.dart';
import '../widgets/right_section.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ReportDetailsCubit, ReportDetailsState>(
        builder: (context, state) {
          switch (state.reportDetailsStatus) {
            case ReportDetailsStatus.loading || ReportDetailsStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case ReportDetailsStatus.error:
              return MyErrorWidget(
                title: 'Error',
                colorScheme: Theme.of(context).colorScheme,
                message: state.loadReportErrorMsg,
                onPressed: () {
                  context.read<ReportDetailsCubit>().loadReportDetails();
                },
              );
            case ReportDetailsStatus.loaded:
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenHeader(
                      title: 'Report Details',
                      subtitle: 'View the details of a report',
                      icon: Icons.edit_document,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Text(
                        'Created by: ${(state.reportDetails?.username == null || state.reportDetails!.username!.isEmpty) ? 'Unknown' : state.reportDetails!.username}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: LeftSection()),
                                SizedBox(width: 32),
                                Expanded(child: RightSection()),
                              ],
                            ),
                            SizedBox(
                              height: 300,
                              child: PartsContent(
                                parts: state.reportDetails?.parts ?? [],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}

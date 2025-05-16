import 'package:flutter/material.dart';

import '../../../reports/presentation/screens/widgets/screen_header.dart';
import '../widgets/left_section.dart';
import '../widgets/right_section.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: LeftSection()),
                    SizedBox(width: 32),
                    Expanded(child: RightSection()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

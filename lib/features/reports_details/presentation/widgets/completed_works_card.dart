import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/widgets/info_card.dart';

class CompletedWorksCard extends StatelessWidget {
  const CompletedWorksCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      title: "Completed Works",
      width: double.infinity,
      child: SizedBox(height: 150),
    );
  }
}

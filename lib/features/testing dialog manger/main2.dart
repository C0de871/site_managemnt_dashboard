import 'package:flutter/material.dart';

import '../reports/presentation/dialogs/report_dialog_service.dart';
import 'ui/my_screen.dart';

void main() {
  final dialogNavKey = GlobalKey<NavigatorState>();
  ReportDialogService().registerNavigationKey(dialogNavKey);

  runApp(MyApp(dialogNavKey));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> dialogNavKey;
  const MyApp(this.dialogNavKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: dialogNavKey, // << Important!
      home: MyScreen(),
    );
  }
}

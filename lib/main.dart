import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/core/utils/services/service_locator.dart';

import 'core/app/app.dart';

void main() async {
  final dialogNavKey = GlobalKey<NavigatorState>();
  await initApp(dialogNavKey);
  runApp(MyApp(dialogNavKey));
}

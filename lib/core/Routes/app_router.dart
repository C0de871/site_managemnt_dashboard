import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/navigation/presentation/cubits/nav_cubit.dart';
import '../../features/reports/presentation/cubits/reports_cubit.dart';
import '../app/app.dart';
import '../helper/cubit_helper.dart';
import 'app_routes.dart';

class AppRouter with CubitProviderMixin {
  //? <======= cubits declration =======>

  //? ||================ choose route ==================||
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //!template screen:

      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => NavigationCubit()),
                ],
                child: const DashboardLayout(),
              ),
        );

      //!default route:
      default:
        return MaterialPageRoute(
          settings: settings,
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text("No route defined for ${settings.name}"),
                ),
              ),
        );
    }
  }
}

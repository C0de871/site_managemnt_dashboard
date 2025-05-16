import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/helper/cubit_helper.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/cubit/report_details_cubit.dart';

import '../../features/generators/presentation/screens/generators_screen.dart';
import '../../features/parts/presentation/screens/materials_screen.dart';
import '../../features/navigation/presentation/cubits/nav_cubit.dart';
import '../../features/navigation/presentation/screens/navigation_panel.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/reports_details/presentation/screens/report_details.dart';
import '../../features/sites/presentation/screens/sites_screen.dart';
import '../Routes/app_router.dart';
import '../Routes/app_routes.dart';
import '../helper/app_functions.dart';
import '../theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [RouteObserverService()],
      debugShowCheckedModeBanner: false,
      title: 'Dashboard App',
      theme: AppTheme().light(),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Navigation Panel
          NavigationPanel(),

          // Main Content Area
          Expanded(child: BodyNavigator()),
        ],
      ),
    );
  }
}

class BodyNavigator extends StatelessWidget with CubitProviderMixin {
  BodyNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme().light().colorScheme.surface,
      child: Navigator(
        key: context.read<NavigationCubit>().navigatorKey,
        initialRoute: AppRoutes.reports,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.reports) {
            return MaterialPageRoute(
              settings: settings,
              builder: (context) {
                return ReportsScreen();
              },
            );
          } else if (settings.name == AppRoutes.reportDetails) {
            return MaterialPageRoute(
              settings: settings,
              builder:
                  (context) => BlocProvider(
                    create:
                        (context) => getCubit<ReportDetailsCubit>(
                          () => ReportDetailsCubit(),
                        ),
                    child: ReportDetailsScreen(),
                  ),
            );
          } else if (settings.name == AppRoutes.sites) {
            return MaterialPageRoute(
              settings: settings,
              builder: (context) => SitesScreen(),
            );
          } else if (settings.name == AppRoutes.generators) {
            return MaterialPageRoute(
              settings: settings,
              builder: (context) => GeneratorsScreen(),
            );
          } else if (settings.name == AppRoutes.materials) {
            return MaterialPageRoute(
              settings: settings,
              builder: (context) => MaterialsScreen(),
            );
          }
          return null;
        },
      ),
    );
  }
}

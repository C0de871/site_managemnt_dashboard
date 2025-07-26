import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/helper/cubit_helper.dart';
import 'package:site_managemnt_dashboard/features/reports/presentation/cubits/reports_cubit.dart';
import 'package:site_managemnt_dashboard/features/reports_details/presentation/cubit/report_details_cubit.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../features/generators/presentation/cubit/generators_cubit.dart';
import '../../features/generators/presentation/screens/generators_screen.dart';
import '../../features/parts/presentation/cubit/parts_cubit.dart';
import '../../features/parts/presentation/screens/parts_screen.dart';
import '../../features/navigation/presentation/cubits/nav_cubit.dart';
import '../../features/navigation/presentation/screens/navigation_panel.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/reports_details/presentation/screens/report_details.dart';
import '../../features/sites/presentation/cubit/sites_cubit.dart';
import '../../features/sites/presentation/screens/sites_screen.dart';
import '../Routes/app_router.dart';
import '../Routes/app_routes.dart';
import '../helper/app_functions.dart';
import '../theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp(this.dialogNavKey, {super.key});

  final GlobalKey<NavigatorState> dialogNavKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: dialogNavKey,
      navigatorObservers: [RouteObserverService()],
      debugShowCheckedModeBanner: false,
      title: 'Dashboard App',
      theme: AppTheme().light(),
      themeMode: ThemeMode.system,
      builder: (context, child) {
        final colorScheme = Theme.of(context).colorScheme;
        return SfDataPagerTheme(
          data: SfDataPagerThemeData(
            selectedItemColor: Theme.of(context).colorScheme.primary,
          ),
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              headerColor: colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.3,
              ),
              gridLineColor: colorScheme.outlineVariant.withValues(alpha: 0.5),
              gridLineStrokeWidth: 1,
              selectionColor: colorScheme.primaryContainer.withValues(
                alpha: 0.3,
              ),
              rowHoverColor: colorScheme.primaryContainer.withValues(
                alpha: 0.1,
              ),
            ),
            child: child!,
          ),
        );
      },
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
                return BlocProvider(
                  create: (context) => ReportsCubit(),
                  child: ReportsScreen(),
                );
              },
            );
          } else if (settings.name == AppRoutes.reportDetails) {
            String reportId = settings.arguments as String;
            return MaterialPageRoute(
              settings: settings,
              builder:
                  (context) => BlocProvider(
                    create:
                        (context) =>
                            ReportDetailsCubit(reportId: reportId)
                              ..loadReportDetails(),
                    child: ReportDetailsScreen(),
                  ),
            );
          } else if (settings.name == AppRoutes.sites) {
            return MaterialPageRoute(
              settings: settings,
              builder:
                  (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => SitesCubit()),
                      BlocProvider(
                        create: (context) => GeneratorsEnginesCubit(),
                      ),
                    ],
                    child: SitesScreen(),
                  ),
            );
          } else if (settings.name == AppRoutes.generators) {
            return MaterialPageRoute(
              settings: settings,
              builder:
                  (context) => BlocProvider(
                    create:
                        (context) =>
                            GeneratorsEnginesCubit()
                              ..loadEngineBrands()
                              ..loadGeneratorBrands()
                              ..loadEngineCapacities()
                              ..loadEngines(),
                    child: GeneratorsScreen(),
                  ),
            );
          } else if (settings.name == AppRoutes.parts) {
            return MaterialPageRoute(
              settings: settings,
              builder:
                  (context) => BlocProvider(
                    create: (context) => PartsCubit(),
                    child: PartsScreen(),
                  ),
            );
          }
          return null;
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/Routes/app_routes.dart';
import 'package:site_managemnt_dashboard/features/navigation/presentation/cubits/nav_cubit.dart';
import 'package:site_managemnt_dashboard/features/navigation/presentation/screens/navigation_panel.dart';
import 'package:site_managemnt_dashboard/features/navigation/presentation/widgets/navigation_item.dart';

class NavigationItems extends StatelessWidget {
  const NavigationItems({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationCubit = context.read<NavigationCubit>();
    final navigatorKey = navigationCubit.navigatorKey;
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            NavigationItem(
              icon: Icons.summarize,
              label: 'Reports',
              isSelected: state.currentPage == NavPage.reports,
              onTap:
              // () => context.read<NavigationCubit>().navigateTo(
              //   NavPage.reports,
              // ),
              () {
                navigatorKey.currentState!.pushNamed(AppRoutes.reports);
                navigationCubit.navigateTo(NavPage.reports);
              },
            ),
            NavigationItem(
              icon: Icons.location_on,
              label: 'Sites',
              isSelected: state.currentPage == NavPage.sites,
              onTap:
              // () =>
              //     context.read<NavigationCubit>().navigateTo(NavPage.sites),
              () {
                navigatorKey.currentState!.pushNamed(AppRoutes.sites);
                navigationCubit.navigateTo(NavPage.sites);
              },
            ),
            NavigationItem(
              icon: Icons.electrical_services,
              label: 'Generators',
              isSelected: state.currentPage == NavPage.generators,
              onTap:
              // () => context.read<NavigationCubit>().navigateTo(
              //   NavPage.generators,
              // ),
              () {
                navigatorKey.currentState!.pushNamed(AppRoutes.generators);
                navigationCubit.navigateTo(NavPage.generators);
              },
            ),
            NavigationItem(
              icon: Icons.category,
              label: 'Parts',
              isSelected: state.currentPage == NavPage.materials,
              onTap:
              // () => context.read<NavigationCubit>().navigateTo(
              //   NavPage.materials,
              // ),
              () {
                navigatorKey.currentState!.pushNamed(AppRoutes.parts);
                navigationCubit.navigateTo(NavPage.materials);
              },
            ),
          ],
        );
      },
    );
  }
}

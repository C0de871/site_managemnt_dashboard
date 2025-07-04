import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/my_error_widget.dart';
import '../../../reports/presentation/screens/widgets/screen_header.dart';
import '../cubit/sites_cubit.dart';
import '../widgets/sites_content.dart';

class SitesScreen extends StatelessWidget {
  const SitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Screen Header
          ScreenHeader(
            title: 'Sites',
            subtitle: 'Manage your sites',
            icon: Icons.energy_savings_leaf_outlined,
          ),

          // Main Content
          Expanded(
            child: BlocBuilder<SitesCubit, SitesState>(
              builder: (context, state) {
                switch (state.sitesStatus) {
                  // case SitesStatus.loading || SitesStatus.initial:
                  //   return Center(
                  //     child: CircularProgressIndicator(
                  //       color: colorScheme.primary,
                  //     ),
                  //   );
                  case SitesStatus.error:
                    return MyErrorWidget(
                      colorScheme: colorScheme,
                      message: state.error,
                      onPressed:
                          () => context.read<SitesCubit>().fetchSites(
                            page: state.lastPageNumber,
                          ),
                      title: 'Error loading sites',
                    );
                  case SitesStatus.loaded ||
                      SitesStatus.loading ||
                      SitesStatus.initial:
                    return SitesContent(
                      sites: state.sitesResponseEntity?.sites ?? [],
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

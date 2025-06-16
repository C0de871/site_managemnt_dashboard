import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/sites/presentation/cubit/sites_cubit.dart';
import 'package:site_managemnt_dashboard/features/sites/presentation/widgets/left_table.dart';
import 'package:site_managemnt_dashboard/features/sites/presentation/widgets/right_table.dart';

import '../../domain/entities/sites_entity.dart';

class SitesContent extends StatelessWidget {
  const SitesContent({super.key, required this.sites});
  final List<SiteEntity> sites;

  @override
  Widget build(BuildContext context) {
    final state = context.read<SitesCubit>().state;
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          LeftTable(),
          state.currentSiteGeneratorsId != -1
              ? SizedBox(width: 32)
              : SizedBox.shrink(),
          RightTable(),
        ],
      ),
    );
  }
}

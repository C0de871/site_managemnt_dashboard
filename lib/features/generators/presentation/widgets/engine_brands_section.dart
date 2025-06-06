import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/services/dialog_launcher.dart';
import '../cubit/generators_cubit.dart';
import 'brands_list.dart';
import 'management_section.dart';

class EngineBrandsSection extends StatelessWidget {
  const EngineBrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GeneratorsEnginesCubit>();
    return ManagementSection(
      title: 'Engine Brands',
      icon: Icons.precision_manufacturing,
      child: BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
        buildWhen:
            (previous, current) =>
                previous.engineBrandsStatus != current.engineBrandsStatus ||
                previous.engineBrands != current.engineBrands,
        builder: (context, state) {
          if (state.engineBrandsStatus.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return BrandsList(
            brands: state.engineBrands,
            onAdd: () => cubit.showBrandDialog(context, isEngine: true),
            onEdit:
                (brand) => cubit.showBrandDialog(
                  context,
                  brand: brand,
                  isEngine: true,
                ),
            onDelete:
                (brand) => DialogLauncher.showConfirmDeleteDialog(
                  context,
                  title: 'Delete Engine Brand',
                  content: 'Are you sure you want to delete "${brand.brand}"?',
                  onConfirm:
                      () => context
                          .read<GeneratorsEnginesCubit>()
                          .deleteEngineBrand(brand.id),
                ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/cubit/generators_cubit.dart';

import '../../../../core/utils/services/dialog_launcher.dart';
import 'brands_list.dart';
import 'management_section.dart';

class GeneratorBrandsSection extends StatelessWidget {
  const GeneratorBrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GeneratorsEnginesCubit>();
    return ManagementSection(
      title: 'Generator Brands',
      icon: Icons.electrical_services,
      child: BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
        buildWhen:
            (previous, current) =>
                previous.generatorBrandsStatus !=
                    current.generatorBrandsStatus ||
                previous.generatorBrands != current.generatorBrands,
        builder: (context, state) {
          if (state.generatorBrandsStatus.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return BrandsList(
            brands: state.generatorBrands,
            onAdd: () => cubit.showBrandDialog(context, isEngine: false),
            onEdit:
                (brand) => cubit.showBrandDialog(
                  context,
                  brand: brand,
                  isEngine: false,
                ),
            onDelete:
                (brand) => DialogLauncher.showConfirmDeleteDialog(
                  context,
                  title: 'Delete Generator Brand',
                  content: 'Are you sure you want to delete "${brand.brand}"?',
                  onConfirm:
                      () => context
                          .read<GeneratorsEnginesCubit>()
                          .deleteGeneratorBrand(brand.id),
                ),
          );
        },
      ),
    );
  }
}

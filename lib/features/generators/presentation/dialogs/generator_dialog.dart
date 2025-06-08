import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/shared/dialog/loading_dialog.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/entities/generator_entity.dart';

import '../cubit/generators_cubit.dart';

class GeneratorDialog extends StatelessWidget {
  GeneratorDialog({
    super.key,
    required this.generator,
    required this.cubit,
    required this.state,
  });

  final GeneratorEntity? generator;
  final GeneratorsEnginesCubit cubit;
  final GeneratorsEnginesState state;
  final TextEditingController initalMeterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int? selectedEngineId = generator?.engine.id;
    int? selectedBrandId = generator?.brand.id;
    int? selectedSiteId = generator?.site?.id;
    initalMeterController.text = generator?.initalMeter ?? "";

    return BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
      builder: (context, state) {
        return state.sitesStatus.isLoading
            ? LoadingDialog()
            : StatefulBuilder(
              builder:
                  (context, setState) => AlertDialog(
                    title: Text(
                      generator == null ? 'Add generator' : 'Edit generator',
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButtonFormField<int>(
                          value: selectedBrandId,
                          decoration: InputDecoration(
                            labelText: 'Generator Brand',
                          ),
                          items:
                              state.generatorBrands
                                  .map(
                                    (brand) => DropdownMenuItem(
                                      value: brand.id,
                                      child: Text(brand.brand),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (value) =>
                                  setState(() => selectedBrandId = value),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          value: selectedEngineId,
                          decoration: InputDecoration(labelText: 'Engine'),
                          items:
                              state.engines
                                  .map(
                                    (engine) => DropdownMenuItem(
                                      value: engine.id,
                                      child: Text(
                                        '${engine.engineBrand.brand} ${engine.engineCapacity.capacity} kW',
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (value) =>
                                  setState(() => selectedEngineId = value),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          value: selectedEngineId,
                          decoration: InputDecoration(labelText: 'Site'),
                          items:
                              state.sites
                                  .map(
                                    (site) => DropdownMenuItem(
                                      value: site.id,
                                      child: Text('${site.name} ${site.code}'),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (value) => setState(() => selectedSiteId = value),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: initalMeterController,
                          decoration: InputDecoration(
                            labelText: "Initial meter",
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (selectedBrandId != null &&
                              selectedEngineId != null &&
                              initalMeterController.text.isNotEmpty) {
                            if (generator == null) {
                              cubit.addGenerator(
                                brandId: selectedBrandId!,
                                engineId: selectedEngineId!,
                                initialMeter: initalMeterController.text,
                                siteId: selectedSiteId,
                              );
                            } else {
                              cubit.updateGenerator(
                                id: generator!.id,
                                brandId: selectedBrandId!,
                                engineId: selectedEngineId!,
                                initialMeter: initalMeterController.text,
                                siteId: selectedSiteId,
                              );
                            }
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(generator == null ? 'Add' : 'Update'),
                      ),
                    ],
                  ),
            );
      },
    );
  }
}

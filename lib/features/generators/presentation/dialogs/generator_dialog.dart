import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/entities/generator_entity.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/entities/sites_entity.dart';

import '../cubit/generators_cubit.dart';
import '../widgets/sites_drop_down.dart';

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
    int? selectedBrandId = generator?.brand?.id;
    int? selectedSiteId = generator?.site?.id;
    initalMeterController.text = generator?.initalMeter ?? "";

    return BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
      builder: (context, state) {
        // return state.sitesStatus.isLoading
        //     ? LoadingDialog()
        //     :
        return StatefulBuilder(
          builder:
              (context, setState) => AlertDialog(
                title: Text(
                  generator == null ? 'Add generator' : 'Edit generator',
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Only show generator brand dropdown when adding new generator
                    if (generator == null) ...[
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
                            (value) => setState(() => selectedBrandId = value),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Only show engine dropdown when adding new generator
                    if (generator == null) ...[
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
                            (value) => setState(() => selectedEngineId = value),
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Modified DropdownSearch widget with pagination
                    SitesDropList(
                      onChanged: (SiteEntity? site) {
                        setState(() => selectedSiteId = site?.id);
                      },
                      selectedItem: generator?.site,
                    ),

                    const SizedBox(height: 16),
                    TextField(
                      controller: initalMeterController,
                      decoration: InputDecoration(labelText: "Initial meter"),
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
                      // Updated validation logic for conditional fields
                      bool isValidForAdd =
                          generator == null &&
                          selectedBrandId != null &&
                          selectedEngineId != null &&
                          initalMeterController.text.isNotEmpty;

                      bool isValidForUpdate =
                          generator != null &&
                          initalMeterController.text.isNotEmpty;

                      if (isValidForAdd || isValidForUpdate) {
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
                            // brandId: selectedBrandId!,
                            // engineId: selectedEngineId!,
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

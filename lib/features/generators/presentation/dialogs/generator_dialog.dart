import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/entities/generator_entity.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/entities/sites_entity.dart';

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
                    DropdownButtonFormField<int>(
                      value: selectedBrandId,
                      decoration: InputDecoration(labelText: 'Generator Brand'),
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
                    // Modified DropdownSearch widget with pagination
                    DropdownSearch<SiteEntity>(
                      // key: cubit.dropdownKey,
                      // selectedItems: site?.generators ?? [],
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'generator site',
                          hintText: 'select site',
                        ),
                      ),
                      compareFn: (a, b) {
                        return a == b;
                      },
                      itemAsString: (site) {
                        return "${site.name} ${site.code}";
                      },
                      popupProps: PopupPropsMultiSelection.menu(
                        menuProps: MenuProps(align: MenuAlign.topCenter),
                        // showSearchBox: true,
                        disableFilter: true,
                        onItemsLoaded: (sites) {
                          log('onItemsLoaded: ${sites.length}');
                        },
                        // Enable infinite scroll for pagination
                        infiniteScrollProps: InfiniteScrollProps(
                          loadProps: LoadProps(skip: 0, take: 20),
                          loadingMoreBuilder:
                              (context, index) => Container(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(width: 16),
                                    Text('Loading more...'),
                                  ],
                                ),
                              ),
                        ),
                        title: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Sites:',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        loadingBuilder: (context, message) {
                          return Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 16),
                                Text(message),
                              ],
                            ),
                          );
                        },
                        // Add search delay to prevent too many API calls
                        searchDelay: Duration(milliseconds: 500),
                      ),

                      // This is where the magic happens - async items with pagination
                      items: (filter, loadProps) async {
                        // final searchQuery = filter;
                        log(loadProps?.skip.toString() ?? "no skip");
                        log(loadProps?.take.toString() ?? "no take");
                        final int page =
                            (((loadProps?.skip ?? 0) / (loadProps?.take ?? 1)) +
                                    1)
                                .ceil();
                        log("page is $page");
                        // Fetch sites from API
                        final sites = await cubit.loadSites(
                          // : searchQuery,
                          page: page,
                        );
                        log(
                          'sites length after the call in the dialog is: ${sites.length}',
                        );
                        return sites;
                      },

                      onChanged: (site) {
                        setState(() => selectedSiteId = site?.id);
                      },

                      // Optional: Add validator
                      // validator: (value) {
                      //   if (value == null) {
                      //     return 'Please select a site';
                      //   }
                      //   return null;
                      // },
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

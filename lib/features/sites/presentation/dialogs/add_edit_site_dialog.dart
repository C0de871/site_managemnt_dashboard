import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/entities/generator_entity.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/entities/sites_entity.dart';
import 'package:site_managemnt_dashboard/features/sites/presentation/cubit/sites_cubit.dart';

class AddEditSiteDialog extends StatelessWidget {
  const AddEditSiteDialog({super.key, this.siteIndex});

  final int? siteIndex;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SitesCubit>();
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<SitesCubit, SitesState>(
      // listener: (context, state) {
      //   if (state.actionStatus.isLoaded) {
      //     Navigator.pop(context);
      //   }
      // },
      builder: (context, state) {
        final SiteEntity? site =
            siteIndex != null
                ? state.sitesResponseEntity?.sites[siteIndex!]
                : null;
        log("${state.generatorStatus}");
        Widget
        generatorsDropDown = DropdownSearch<GeneratorEntity>.multiSelection(
          key: cubit.dropdownKey,
          selectedItems: site?.generators ?? [],
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: 'site generators',
              hintText: 'Select generator',
            ),
          ),
          compareFn: (a, b) {
            return a == b;
          },

          itemAsString: (generator) {
            return "${generator.brand?.brand ?? "غير معروف"} ${generator.engine.engineBrand.brand} ${generator.engine.engineCapacity.capacity}";
          },
          popupProps: PopupPropsMultiSelection.menu(
            menuProps: MenuProps(align: MenuAlign.topCenter),
            showSelectedItems: true,
            showSearchBox: true,
            title: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Generators:',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            loadingBuilder: (context, message) {
              return Text(message);
            },
          ),
          items: (f, cs) => cubit.fetchFreeGenerators(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a generator';
            }
            return null;
          },
        );

        return AlertDialog(
          title: Text(site == null ? 'Add site' : 'Edit site'),
          content: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Form(
              key: cubit.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: cubit.siteNameController,
                    decoration: InputDecoration(labelText: 'Site Name'),
                    autofocus: true,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: cubit.siteCodeController,
                    decoration: InputDecoration(labelText: 'Site Code'),
                  ),
                  const SizedBox(height: 16),
                  // if (state.generatorStatus.isLoading)
                  //   Center(child: CircularProgressIndicator()),
                  // if (state.generatorStatus.isLoaded && site != null)
                  //   generatorsDropDown,
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed:
                  state.actionStatus.isLoading
                      ? null
                      : () async {
                        site == null
                            ? await cubit.addEditSite()
                            : await cubit.addEditSite(siteId: site.id);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
              child:
                  state.actionStatus.isLoading
                      ? CircularProgressIndicator(
                        padding: EdgeInsets.all(8),
                        color: colors.onPrimary,
                      )
                      : Text(site == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}

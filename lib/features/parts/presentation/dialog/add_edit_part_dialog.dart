
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../engines/domain/entities/engine_entity.dart';
import '../../domain/entities/part_entity.dart';
import '../cubit/parts_cubit.dart';

class AddEditPartDialog extends StatelessWidget {
  const AddEditPartDialog({super.key, this.part});

  final PartEntity? part;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PartsCubit>();
    final colors = Theme.of(context).colorScheme;
    List<EngineEntity> selectedEngines = [];
    return BlocBuilder<PartsCubit, PartsState>(
      builder: (context, state) {
        Widget partsDropDown = DropdownSearch<EngineEntity>.multiSelection(
          key: cubit.dropdownKey,
          // selectedItems: part?.engines ?? [],
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: 'Apropriate engines',
              hintText: 'Select engines',
            ),
          ),
          compareFn: (a, b) {
            return a == b;
          },

          itemAsString: (engine) {
            return "${engine.engineBrand.brand} ${engine.engineCapacity.capacity}Kw";
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
                'Engines:',
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
          items: (f, cs) => cubit.loadEngines(),
          onChanged: (engines) {
            selectedEngines = engines;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a generator';
            }
            return null;
          },
        );

        return AlertDialog(
          title: Text(part == null ? 'Add part' : 'Edit part'),
          content: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Form(
              key: cubit.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: cubit.partNameController,
                    decoration: InputDecoration(labelText: 'Part Name'),
                    autofocus: true,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: cubit.partCodeController,
                    decoration: InputDecoration(labelText: 'Part Code'),
                  ),
                  const SizedBox(height: 16),
                  // if (partIndex == null) partsDropDown,
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
              onPressed: () {
                if (!cubit.formKey.currentState!.validate()) return;
                final part = this.part;
                if (part != null) {
                  cubit.editPart(part.id);
                }
                cubit.addPart(selectedEngines);
              },
              child:
                  state.actionStatus.isLoading
                      ? CircularProgressIndicator(
                        padding: EdgeInsets.all(8),
                        color: colors.onPrimary,
                      )
                      : Text(part == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}

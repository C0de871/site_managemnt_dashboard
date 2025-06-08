// import 'dart:developer';

// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:site_managemnt_dashboard/features/generators/domain/entities/generator_entity.dart';
// import 'package:site_managemnt_dashboard/features/parts/domain/entities/part_entity.dart';
// import 'package:site_managemnt_dashboard/features/sites/domain/entities/sites_entity.dart';
// import 'package:site_managemnt_dashboard/features/sites/presentation/cubit/sites_cubit.dart';

// import '../../../engines/domain/entities/engine_entity.dart';
// import '../cubit/parts_cubit.dart';

// class AddEditPartDialog extends StatelessWidget {
//   const AddEditPartDialog({super.key, this.part});

//   final PartEntity? part;

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<PartsCubit>();
//     final colors = Theme.of(context).colorScheme;
//     return BlocConsumer<PartsCubit, PartsState>(
//       listener: (context, state) {
//         if (state.actionStatus.isLoaded) {
//           Navigator.pop(context);
//         }
//       },
//       builder: (context, state) {
//         Widget partsDropDown = DropdownSearch<EngineEntity>.multiSelection(
//           key: cubit.dropdownKey,
//           selectedItems: part?.engines ?? [],
//           decoratorProps: DropDownDecoratorProps(
//             decoration: InputDecoration(
//               labelText: 'Apropriate engines',
//               hintText: 'Select engines',
//             ),
//           ),
//           compareFn: (a, b) {
//             return a == b;
//           },

//           itemAsString: (engine) {
//             return "${engine.engineBrand.brand} ${engine.engineCapacity.capacity}Kw";
//           },
//           popupProps: PopupPropsMultiSelection.menu(
//             menuProps: MenuProps(align: MenuAlign.topCenter),
//             showSelectedItems: true,
//             showSearchBox: true,
//             title: Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.primaryContainer,
//               ),
//               alignment: Alignment.center,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Text(
//                 'Engines:',
//                 style: TextStyle(
//                   fontSize: 21,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).colorScheme.onPrimaryContainer,
//                 ),
//               ),
//             ),
//             loadingBuilder: (context, message) {
//               return Text(message);
//             },
//           ),
//           items: (f, cs) => cubit.fetchFreeGenerators(),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please select a generator';
//             }
//             return null;
//           },
//         );

//         return AlertDialog(
//           title: Text(site == null ? 'Add site' : 'Edit site'),
//           content: ConstrainedBox(
//             constraints: BoxConstraints(maxWidth: 400),
//             child: Form(
//               key: cubit.formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: cubit.partNameController,
//                     decoration: InputDecoration(labelText: 'Site Name'),
//                     autofocus: true,
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: cubit.partCodeController,
//                     decoration: InputDecoration(labelText: 'Site Code'),
//                   ),
//                   const SizedBox(height: 16),
//                   if (state.generatorStatus.isLoading)
//                     Center(child: CircularProgressIndicator()),
//                   if (state.generatorStatus.isLoaded) partsDropDown,
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: cubit.addEditSite,
//               child:
//                   state.actionStatus.isLoading
//                       ? CircularProgressIndicator(
//                         padding: EdgeInsets.all(8),
//                         color: colors.onPrimary,
//                       )
//                       : Text(site == null ? 'Add' : 'Update'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

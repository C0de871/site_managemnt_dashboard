import 'package:bloc/bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/entities/generator_entity.dart';
import 'package:site_managemnt_dashboard/features/parts/domain/entities/part_entity.dart';

import '../../../engine_brands/domain/entities/brand_entity.dart';
import '../../../engine_capacities/domain/entities/engine_capacity_entity.dart';
import '../../../engines/domain/entities/engine_entity.dart';

part 'parts_state.dart';

class PartsCubit extends Cubit<PartsState> {
  PartsCubit() : super(const PartsState());

  final TextEditingController partNameController = TextEditingController();
  final TextEditingController partCodeController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final GlobalKey<DropdownSearchState<GeneratorEntity>> dropdownKey =
      GlobalKey<DropdownSearchState<GeneratorEntity>>();

  Future<void> fetchParts() async {
    emit(state.copyWith(partsStatus: PartsStatus.loading));
    Future.delayed(const Duration(seconds: 2));
    final parts = List<PartEntity>.generate(
      30,
      (index) => PartEntity(
        id: index + 1,
        name: 'part $index',
        code: '${index + 1}000',
        isGeneral: true,
        engines: [
          EngineEntity(
            id: index + 1,
            engineBrand: BrandEntity(
              id: index + 1,
              brand: 'Engine Brand $index',
            ),
            engineCapacity: EngineCapacityEntity(id: index + 1, capacity: 100),
          ),
        ],
      ),
    );
    emit(state.copyWith(partsStatus: PartsStatus.loaded, parts: parts));
  }

  void deleteSelectedParts() {
    emit(state.copyWith(actionStatus: PartsStatus.loading));
    Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(actionStatus: PartsStatus.loaded));
  }

  void deleteSelectedEngines() {
    emit(state.copyWith(actionStatus: PartsStatus.loading));
    Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(actionStatus: PartsStatus.loaded));
  }

  void togglePartSelection(String partId) {
    if (state.partsStatus.isLoaded) {
      final selectedIds = Set<String>.from(state.selectedPartIds);

      if (selectedIds.contains(partId)) {
        selectedIds.remove(partId);
      } else {
        selectedIds.add(partId);
      }

      emit(state.copyWith(selectedPartIds: selectedIds));
    }
  }

  void selectAllParts(bool selected) {
    if (state.partsStatus.isLoaded) {
      final Set<String> selectedIds =
          selected ? Set.from(state.parts.map((r) => r.id)) : {};

      emit(state.copyWith(selectedPartIds: selectedIds));
    }
  }

  void setCurrentPartEnginesId(int? partId) {
    if (partId != state.currentPartEnginesId) {
      emit(state.copyWith(currentPartEnginesId: partId));
    } else {
      emit(state.copyWith(currentPartEnginesId: null));
    }
  }

  void toggleEngineSelection(String engineId) {
    if (state.partsStatus.isLoaded) {
      final selectedIds = Set<String>.from(state.selectedEngineIds);

      if (selectedIds.contains(engineId)) {
        selectedIds.remove(engineId);
      } else {
        selectedIds.add(engineId);
      }

      emit(state.copyWith(selectedEngineIds: selectedIds));
    }
  }

  void selectAllEngines(bool selected, int partId) {
    if (state.partsStatus.isLoaded) {
      final Set<String> selectedIds =
          selected
              ? Set.from(state.parts[partId].engines.map((r) => r.id))
              : {};

      emit(state.copyWith(selectedEngineIds: selectedIds));
    }
  }

   // Engines Management
  // void loadEngines() {
  //   emit(state.copyWith(enginesStatus: GeneratorsEnginesStatus.loading));
  //   try {
  //     final engines = [
  //       EngineEntity(
  //         id: 1,
  //         engineBrand: state.engineBrands.first,
  //         engineCapacity: state.engineCapacities.first,
  //       ),
  //     ];
  //     emit(
  //       state.copyWith(
  //         enginesStatus: GeneratorsEnginesStatus.loaded,
  //         engines: engines,
  //       ),
  //     );
  //   } catch (e) {
  //     emit(
  //       state.copyWith(
  //         enginesStatus: GeneratorsEnginesStatus.error,
  //         error: e.toString(),
  //       ),
  //     );
  //   }
  // }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:site_managemnt_dashboard/core/databases/params/params.dart';
import 'package:site_managemnt_dashboard/core/shared/domain/entities/pagination_entity.dart';
import 'package:site_managemnt_dashboard/features/engines/domain/usecases/get_engines_usecase.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/entities/generator_entity.dart';
import 'package:site_managemnt_dashboard/features/parts/domain/entities/part_entity.dart';
import 'package:site_managemnt_dashboard/features/parts/domain/usecases/add_part_usecase.dart';
import 'package:site_managemnt_dashboard/features/parts/domain/usecases/delete_part_usecase.dart';
import 'package:site_managemnt_dashboard/features/parts/domain/usecases/get_parts_usecase.dart';
import 'package:site_managemnt_dashboard/features/parts/presentation/dialog/add_edit_part_dialog.dart';

import '../../../../core/databases/params/body.dart';
import '../../../../core/utils/services/service_locator.dart';
import '../../../engines/domain/entities/engine_entity.dart';
import '../../domain/usecases/edit_part_usecase.dart';

part 'parts_state.dart';

class PartsCubit extends Cubit<PartsState> {
  PartsCubit() : super(const PartsState());

  final TextEditingController partNameController = TextEditingController();
  final TextEditingController partCodeController = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final GlobalKey<DropdownSearchState<GeneratorEntity>> dropdownKey =
      GlobalKey<DropdownSearchState<GeneratorEntity>>();

  final GetPartsUsecase _getPartsUsecase = getIt();
  final AddPartUsecase _addPartUsecase = getIt();
  final DeletePartsUsecase _deletePartsUsecase = getIt();
  final EditPartUsecase _editPartUsecase = getIt();

  final GetEnginesUseCase _getEnginesUseCase = getIt();

  Future<void> searchParts({int page = 1}) async {
    emit(state.copyWith(partsStatus: PartsStatus.loading));
    final response = await _getPartsUsecase.call(
      params: SearchPartsWithPagination(
        page: page,
        searchQuery: searchController.text,
      ),
    );
    response.fold(
      (failure) => emit(
        state.copyWith(
          partsStatus: PartsStatus.error,
          error: failure.errMessage,
        ),
      ),
      (data) => emit(
        state.copyWith(
          partsStatus: PartsStatus.loaded,
          parts: data.parts,
          pagination: data.pagination,
        ),
      ),
    );
  }

  Future<void> addPart(List<EngineEntity> engines, bool isPrimary) async {
    log("engines in the add part method is ${engines.length}");
    emit(state.copyWith(actionStatus: PartsStatus.loading));
    final body = AddPartBody(
      name: partNameController.text,
      code: partCodeController.text,
      isGeneral: engines.isEmpty ? "1" : "0",
      enginesId: engines.map((e) => e.id.toString()).toList(),
      isPrimary: isPrimary,
    );
    final response = await _addPartUsecase.call(body);
    response.fold(
      (failure) => emit(
        state.copyWith(
          actionStatus: PartsStatus.error,
          error: failure.errMessage,
        ),
      ),
      (data) => emit(
        state.copyWith(
          actionStatus: PartsStatus.loaded,
          parts: [...state.parts, data],
        ),
      ),
    );
  }

  Future<void> editPart(int partId, bool isPrimary) async {
    emit(state.copyWith(actionStatus: PartsStatus.loading));
    final body = EditPartBody(
      id: partId.toString(),
      name: partNameController.text,
      code: partCodeController.text,
      isPrimary: isPrimary,
    );

    final updatedParts =
        state.parts.map((part) {
          if (part.id == partId) {
            return part.copyWith(
              name: body.name,
              code: body.code,
              isPrimary: body.isPrimary,
            );
          }
          return part;
        }).toList();

    final response = await _editPartUsecase.call(body);

    response.fold(
      (failure) => emit(
        state.copyWith(
          actionStatus: PartsStatus.error,
          error: failure.errMessage,
        ),
      ),
      (data) => emit(
        state.copyWith(actionStatus: PartsStatus.loaded, parts: updatedParts),
      ),
    );
  }

  Future<void> deleteSelectedParts() async {
    emit(state.copyWith(actionStatus: PartsStatus.loading));
    final response = await _deletePartsUsecase.call(
      DeletePartBody(ids: state.selectedPartIds.toList()),
    );
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            actionStatus: PartsStatus.error,
            error: failure.errMessage,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(actionStatus: PartsStatus.loaded, selectedPartIds: {}),
        );
        searchParts(page: state.pagination.currentPage!);
      },
    );
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
      emit(state.copyWith(currentPartEnginesId: -1));
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

  void showAddEditPartDialog(BuildContext parentContext, [PartEntity? part]) {
    // if (index != null) {
    //   fetchFreeGenerators();
    // }
    if (part != null) {
      partNameController.setText(part.name);
      partCodeController.setText(part.code ?? "");
    }

    showDialog(
      context: parentContext,
      builder:
          (context) => BlocProvider.value(
            value: this,
            child: AddEditPartDialog(part: part),
          ),
    );
  }

  Future<List<EngineEntity>> loadEngines() async {
    emit(state.copyWith(engineStatus: AvailableEnginesStatus.loading));
    final response = await _getEnginesUseCase.call();
    List<EngineEntity> engines = [];
    response.fold(
      (failure) => emit(
        state.copyWith(
          engineStatus: AvailableEnginesStatus.error,
          error: failure.errMessage,
        ),
      ),
      (data) {
        engines = data;
        emit(
          state.copyWith(
            engineStatus: AvailableEnginesStatus.loaded,
            availableEngines: data,
          ),
        );
      },
    );
    return engines;
  }
}

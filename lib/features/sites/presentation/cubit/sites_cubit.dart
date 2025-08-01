import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:site_managemnt_dashboard/core/databases/params/body.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/usecases/get_generators_by_site_id.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/cubit/generators_cubit.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/entities/sites_response_entity.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/usecases/add_site_usecase.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/usecases/delete_site_usecase.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/usecases/edit_site_usecase.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/usecases/search_site_usecase.dart';

import '../../../../core/utils/services/service_locator.dart';
import '../../../engine_brands/domain/entities/brand_entity.dart';
import '../../../engine_capacities/domain/entities/engine_capacity_entity.dart';
import '../../../engines/domain/entities/engine_entity.dart';
import '../../../generators/domain/entities/generator_entity.dart';
import '../dialogs/add_edit_site_dialog.dart';

part 'sites_state.dart';

class SitesCubit extends Cubit<SitesState> {
  SitesCubit() : super(const SitesState());

  final SearchSitesUseCase _searchSitesUseCase = getIt<SearchSitesUseCase>();

  final GetGeneratorsBySiteIDUsecase _getAllSiteGeneratorsUseCase =
      getIt<GetGeneratorsBySiteIDUsecase>();

  final EditSiteUseCase _editSiteUseCase = getIt<EditSiteUseCase>();
  final AddSiteUseCase _addSiteUseCase = getIt<AddSiteUseCase>();
  final DeleteSiteUseCase _deleteSitesUseCase = getIt<DeleteSiteUseCase>();

  final TextEditingController siteNameController = TextEditingController();
  final TextEditingController siteCodeController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final GlobalKey<DropdownSearchState<GeneratorEntity>> dropdownKey =
      GlobalKey<DropdownSearchState<GeneratorEntity>>();

  final TextEditingController searchController = TextEditingController();

  Future<void> searchSites({int page = 1}) async {
    emit(state.copyWith(sitesStatus: SitesStatus.loading));
    final response = await _searchSitesUseCase.call(
      body: SearchSitesWithPagination(
        page: page,
        searchQuery: searchController.text,
      ),
    );
    response.fold(
      (l) => emit(
        SitesState(
          sitesStatus: SitesStatus.error,
          error: l.errMessage,
          lastPageNumber: page,
        ),
      ),
      (sitesResponseEntity) {
        log(sitesResponseEntity.toString());
        emit(
          state.copyWith(
            sitesStatus: SitesStatus.loaded,
            sitesResponseEntity: sitesResponseEntity,
            lastPageNumber: page,
          ),
        );
      },
    );
  }

  Future<void> fetchGenerators(int siteID) async {
    bool isLoaded =
        state.sitesResponseEntity?.sites
            .firstWhere((site) => site.id == siteID)
            .generators
            ?.isNotEmpty ??
        false;
    if (isLoaded) {
      emit(
        state.copyWith(
          generatorStatus: SitesStatus.loaded,
          currentSiteGeneratorsId: siteID,
        ),
      );
      return;
    }
    emit(state.copyWith(generatorStatus: SitesStatus.loading));
    final response = await _getAllSiteGeneratorsUseCase.call(siteID: siteID);

    response.fold(
      (failure) {
        emit(
          state.copyWith(
            generatorStatus: SitesStatus.error,
            error: failure.errMessage,
          ),
        );
      },
      (generators) {
        final newSitesResponseEntity = state.sitesResponseEntity?.copyWith(
          sites:
              state.sitesResponseEntity!.sites.map((site) {
                if (site.id == siteID) {
                  return site.copyWith(generators: generators.generators);
                }
                return site;
              }).toList(),
        );
        emit(
          state.copyWith(
            generatorStatus: SitesStatus.loaded,
            sitesResponseEntity: newSitesResponseEntity,
            currentSiteGeneratorsId: siteID,
          ),
        );
      },
    );
  }

  Future<List<GeneratorEntity>> fetchFreeGenerators() async {
    emit(state.copyWith(freeGeneratorsStatus: GeneratorsEnginesStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    List<GeneratorEntity> freeGenerators = List.generate(
      20,
      (index) => GeneratorEntity(
        id: index + 1,
        brand: BrandEntity(id: index + 1, brand: 'brand $index'),
        engine: EngineEntity(
          id: index + 1,
          engineBrand: BrandEntity(id: index + 1, brand: 'brand $index'),
          engineCapacity: EngineCapacityEntity(
            id: index + 1,
            capacity: index + 1,
          ),
        ),
        initalMeter: '123.456',
      ),
    );
    emit(
      state.copyWith(
        freeGeneratorsStatus: GeneratorsEnginesStatus.loaded,
        freeGenerators: freeGenerators,
      ),
    );
    return freeGenerators;
  }

  Future<void> deleteSelectedSites() async {
    emit(state.copyWith(actionStatus: SitesStatus.loading));
    final response = await _deleteSitesUseCase.call(
      DeleteSiteBody(ids: state.selectedSiteIds.toList()),
    );
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            actionStatus: SitesStatus.error,
            error: failure.errMessage,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(actionStatus: SitesStatus.loaded, selectedSiteIds: {}),
        );
        searchSites(page: state.sitesResponseEntity!.pagination.currentPage!);
      },
    );
  }

  void showAddEditSiteDialog(BuildContext parentContext, [int? index]) {
    // if (index != null) {
    //   fetchFreeGenerators();
    // }
    siteNameController.setText(
      state.sitesResponseEntity?.sites[index!].name ?? "",
    );
    siteCodeController.setText(
      state.sitesResponseEntity?.sites[index!].code ?? "",
    );
    showDialog(
      context: parentContext,
      builder:
          (context) => BlocProvider.value(
            value: this,
            child: AddEditSiteDialog(siteIndex: index),
          ),
    );
  }

  void toggleSiteSelection(String siteId) {
    if (state.sitesStatus.isLoaded) {
      final selectedIds = Set<String>.from(state.selectedSiteIds);

      if (selectedIds.contains(siteId)) {
        selectedIds.remove(siteId);
      } else {
        selectedIds.add(siteId);
      }

      emit(state.copyWith(selectedSiteIds: selectedIds));
    }
  }

  void selectAllSites(bool selected) {
    // if (state.sitesStatus.isLoaded) {
    //   final Set<String> selectedIds =
    //       selected ? Set.from(state.sites.map((r) => r.id)) : {};

    //   emit(state.copyWith(selectedSiteIds: selectedIds));
    // }
  }

  void setCurrentSiteGeneratorsId(int siteId) {
    log('siteId: $siteId');
    if (siteId != state.currentSiteGeneratorsId) {
      fetchGenerators(siteId);
    } else {
      emit(state.copyWith(currentSiteGeneratorsId: -1));
    }
  }

  void toggleGeneratorSelection(String generatorId) {
    if (state.sitesStatus.isLoaded) {
      final selectedIds = Set<String>.from(state.selectedGeneratorIds);

      if (selectedIds.contains(generatorId)) {
        selectedIds.remove(generatorId);
      } else {
        selectedIds.add(generatorId);
      }

      emit(state.copyWith(selectedGeneratorIds: selectedIds));
    }
  }

  Future<void> addEditSite({int? siteId}) async {
    if (siteId != null) {
      _editSite(siteId);
    } else {
      _addSite();
    }
  }

  Future<void> _addSite() async {
    final AddSiteBody body = AddSiteBody(
      name: siteNameController.text,
      code: siteCodeController.text,
    );
    final response = await _addSiteUseCase.call(body);

    response.fold(
      (failure) {
        emit(
          state.copyWith(
            actionStatus: SitesStatus.error,
            error: failure.errMessage,
          ),
        );
      },
      (site) {
        emit(state.copyWith(actionStatus: SitesStatus.loaded));
      },
    );
  }

  Future<void> _editSite(int siteId) async {
    final EditSiteBody body = EditSiteBody(
      name: siteNameController.text,
      code: siteCodeController.text,
      id: siteId.toString(),
    );
    emit(state.copyWith(actionStatus: SitesStatus.loading));
    final response = await _editSiteUseCase.call(body);

    response.fold(
      (failure) {
        emit(
          state.copyWith(
            actionStatus: SitesStatus.error,
            error: failure.errMessage,
          ),
        );
      },
      (site) {
        final sitesResponseEntity = state.sitesResponseEntity;
        final newSitesResponse = sitesResponseEntity?.copyWith(
          sites:
              sitesResponseEntity.sites.map((site) {
                if (site.id == siteId) {
                  return site.copyWith(name: body.name, code: body.code);
                }
                return site;
              }).toList(),
        );
        emit(
          state.copyWith(
            actionStatus: SitesStatus.loaded,
            sitesResponseEntity: newSitesResponse,
          ),
        );
      },
    );
  }
}

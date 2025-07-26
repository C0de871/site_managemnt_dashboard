import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:site_managemnt_dashboard/core/databases/params/body.dart';
import 'package:site_managemnt_dashboard/core/shared/domain/entities/pagination_entity.dart';
import 'package:site_managemnt_dashboard/features/engine_brands/domain/usecases/add_engine_brand_usecase.dart';
import 'package:site_managemnt_dashboard/features/engine_brands/domain/usecases/delete_engines_brands_usecase.dart';
import 'package:site_managemnt_dashboard/features/engine_brands/domain/usecases/get_engines_brands_usecase.dart';
import 'package:site_managemnt_dashboard/features/engine_capacities/domain/usecases/add_engine_capacity_usecase.dart';
import 'package:site_managemnt_dashboard/features/engine_capacities/domain/usecases/delete_engine_capacity_usecase.dart';
import 'package:site_managemnt_dashboard/features/engines/domain/usecases/add_engine_usecase.dart';
import 'package:site_managemnt_dashboard/features/engines/domain/usecases/delete_engine_usecase.dart';
import 'package:site_managemnt_dashboard/features/engines/domain/usecases/get_engines_usecase.dart';
import 'package:site_managemnt_dashboard/features/generator_brand/domain/usecases/delete_generator_brand_usecase.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/usecases/create_generators_usecase.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/usecases/delete_generators_usecase.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/usecases/edit_generators_usecase.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/usecases/get_generators_usecase.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/dialogs/generator_dialog.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/usecases/search_site_usecase.dart';

import '../../../../core/utils/services/service_locator.dart';
import '../../../engine_brands/domain/entities/brand_entity.dart';
import '../../../engine_brands/domain/usecases/edit_engine_brand_usecase.dart';
import '../../../engine_capacities/domain/entities/engine_capacity_entity.dart';
import '../../../engine_capacities/domain/usecases/edit_engine_capacity_usecase.dart';
import '../../../engine_capacities/domain/usecases/get_engine_capacities_usecase.dart';
import '../../../engines/domain/entities/engine_entity.dart';
import '../../../engines/domain/usecases/edit_engine_usecase.dart';
import '../../../generator_brand/domain/usecases/add_generator_brand_usecase.dart';
import '../../../generator_brand/domain/usecases/edit_generator_brand_usecase.dart';
import '../../../generator_brand/domain/usecases/get_generator_brands_usecase.dart';
import '../../../sites/domain/entities/sites_entity.dart';
import '../../domain/entities/generator_entity.dart';
import '../dialogs/brand_dialog.dart';
import '../dialogs/capacity_dialog.dart';
import '../dialogs/engine_dialog.dart';

part 'generators_state.dart';

class GeneratorsEnginesCubit extends Cubit<GeneratorsEnginesState> {
  GeneratorsEnginesCubit() : super(const GeneratorsEnginesState());

  final TextEditingController capacityController = TextEditingController();
  final TextEditingController brandController = TextEditingController();

  //!Generators use case
  final GetGeneratorsUseCase _getGeneratorsUseCase = getIt();
  final CreateGeneratorUsecase _createGeneratorUsecase = getIt();
  final DeleteGeneratorsUsecase _deleteGeneratorsUsecase = getIt();
  final EditGeneratorUsecase _editGeneratorUsecase = getIt();

  //!Engine brand use case
  final GetEngineBrandsUsecase _getEngineBrandsUsecase = getIt();
  final AddEngineBrandUsecase _addEngineBrandUsecase = getIt();
  final DeleteEngineBrandsUsecase _deleteEngineBrandsUsecase = getIt();
  final EditEngineBrandUsecase _editEngineBrandUsecase = getIt();

  //!Generator brand use case
  final GetGeneratorBrandsUsecase _getGeneratorBrandsUsecase = getIt();
  final AddGeneratorBrandUsecase _addGeneratorBrandUsecase = getIt();
  final DeleteGeneratorBrandsUsecase _deleteGeneratorBrandsUsecase = getIt();
  final EditGeneratorBrandUsecase _editGeneratorBrandUsecase = getIt();

  //!Engine capacity use case
  final GetEngineCapacitiesUsecase _getEngineCapacitiesUsecase = getIt();
  final AddEngineCapacityUsecase _addEngineCapacityUsecase = getIt();
  final DeleteEngineCapacitiesUsecase _deleteEngineCapacitiesUsecase = getIt();
  final EditEngineCapacityUsecase _editEngineCapacityUsecase = getIt();

  //!Sites use case
  final SearchSitesUseCase _searchSitesUseCase = getIt();

  //!Engines use case
  final GetEnginesUseCase _getEnginesUsecase = getIt();
  final CreateEngineUseCase _createEngineUseCase = getIt();
  final DeleteEnginesUseCase _deleteEnginesUseCase = getIt();
  final EditEngineUseCase _editEngineUseCase = getIt();

  Future<void> fetchGenerators({int page = 1}) async {
    emit(state.copyWith(generatorsStatus: GeneratorsEnginesStatus.loading));
    final response = await _getGeneratorsUseCase.call(page: page);
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            generatorsStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        );
      },
      (generatorsResponse) {
        emit(
          state.copyWith(
            generatorsStatus: GeneratorsEnginesStatus.loaded,
            generators: generatorsResponse.generators,
            pagination: generatorsResponse.pagination,
          ),
        );
      },
    );
  }

  void deleteSelectedGenerators() {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loaded));
  }

  void toggleGeneratorSelection(String partId) {
    if (state.generatorsStatus.isLoaded) {
      final selectedIds = Set<String>.from(state.selectedGeneratorIds);

      if (selectedIds.contains(partId)) {
        selectedIds.remove(partId);
      } else {
        selectedIds.add(partId);
      }

      emit(state.copyWith(selectedGeneratorIds: selectedIds));
    }
  }

  void selectAllGenerators(bool selected) {
    if (state.generatorsStatus.isLoaded) {
      final Set<String> selectedIds =
          selected ? Set.from(state.generators.map((r) => r.id)) : {};

      emit(state.copyWith(selectedGeneratorIds: selectedIds));
    }
  }

  // Engine Brands Management
  Future<void> loadEngineBrands() async {
    emit(state.copyWith(engineBrandsStatus: GeneratorsEnginesStatus.loading));

    // Simulate API call - replace with actual data fetching
    // final brands = [
    //   const BrandEntity(id: 1, brand: 'Caterpillar'),
    //   const BrandEntity(id: 2, brand: 'Cummins'),
    //   const BrandEntity(id: 3, brand: 'Perkins'),
    // ];

    final response = await _getEngineBrandsUsecase.call();

    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            engineBrandsStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (brands) {
        emit(
          state.copyWith(
            engineBrandsStatus: GeneratorsEnginesStatus.loaded,
            engineBrands: brands,
          ),
        );
      },
    );
  }

  Future<void> addEngineBrand(String brandName) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final body = AddEngineBrandBody(brand: brandName);

    log("request");
    final response = await _addEngineBrandUsecase.call(body);

    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (brand) {
        final updatedBrands = [...state.engineBrands, brand];
        return {
          emit(
            state.copyWith(
              engineBrands: updatedBrands,
              actionStatus: GeneratorsEnginesStatus.loaded,
            ),
          ),
        };
      },
    );
  }

  Future<void> updateEngineBrand(int id, String brandName) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final updatedBrands =
        state.engineBrands.map((brand) {
          return brand.id == id ? brand.copyWith(brand: brandName) : brand;
        }).toList();

    final EditBrandBody body = EditBrandBody(
      id: id.toString(),
      brand: brandName,
    );
    final response = await _editEngineBrandUsecase.call(body);
    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (brand) {
        return {
          emit(
            state.copyWith(
              engineBrands: updatedBrands,
              actionStatus: GeneratorsEnginesStatus.loaded,
            ),
          ),
        };
      },
    );
  }

  Future<void> deleteEngineBrand(int id) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final response = await _deleteEngineBrandsUsecase.call(
      DeleteEngineBrandBody(ids: [id.toString()]),
    );

    response.fold(
      (failure) {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        );
      },
      (success) {
        emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loaded));
        loadEngineBrands();
      },
    );
  }

  // Generator Brands Management
  Future<void> loadGeneratorBrands() async {
    emit(
      state.copyWith(generatorBrandsStatus: GeneratorsEnginesStatus.loading),
    );

    final response = await _getGeneratorBrandsUsecase.call();

    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            generatorBrandsStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (brands) {
        emit(
          state.copyWith(
            generatorBrandsStatus: GeneratorsEnginesStatus.loaded,
            generatorBrands: brands,
          ),
        );
      },
    );
  }

  Future<void> addGeneratorBrand(String brandName) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final body = AddGeneratorBrandBody(brand: brandName);

    final response = await _addGeneratorBrandUsecase.call(body);

    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (brand) {
        final updatedBrands = [...state.generatorBrands, brand];
        return {
          emit(
            state.copyWith(
              generatorBrands: updatedBrands,
              actionStatus: GeneratorsEnginesStatus.loaded,
            ),
          ),
        };
      },
    );
  }

  Future<void> updateGeneratorBrand(int id, String brandName) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final updatedBrands =
        state.generatorBrands.map((brand) {
          return brand.id == id ? brand.copyWith(brand: brandName) : brand;
        }).toList();

    final EditBrandBody body = EditBrandBody(
      id: id.toString(),
      brand: brandName,
    );
    final response = await _editGeneratorBrandUsecase.call(body);
    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (brand) {
        return {
          emit(
            state.copyWith(
              generatorBrands: updatedBrands,
              actionStatus: GeneratorsEnginesStatus.loaded,
            ),
          ),
        };
      },
    );
  }

  Future<void> deleteGeneratorBrand(int id) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final response = await _deleteGeneratorBrandsUsecase.call(
      DeleteGeneratorBrandBody(ids: [id.toString()]),
    );

    response.fold(
      (failure) {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        );
      },
      (success) {
        emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loaded));
        loadGeneratorBrands();
      },
    );
  }

  // Engine Capacities Management
  void loadEngineCapacities() async {
    emit(
      state.copyWith(engineCapacitiesStatus: GeneratorsEnginesStatus.loading),
    );

    final response = await _getEngineCapacitiesUsecase.call();

    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            engineCapacitiesStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (capacities) {
        emit(
          state.copyWith(
            engineCapacitiesStatus: GeneratorsEnginesStatus.loaded,
            engineCapacities: capacities,
          ),
        );
      },
    );
  }

  Future<void> addEngineCapacity(int capacity) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final body = AddEngineCapacityBody(capacity: capacity.toString());

    final response = await _addEngineCapacityUsecase.call(body);

    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (capacity) {
        final updatedCapacities = [...state.engineCapacities, capacity];
        return {
          emit(
            state.copyWith(
              engineCapacities: updatedCapacities,
              actionStatus: GeneratorsEnginesStatus.loaded,
            ),
          ),
        };
      },
    );
  }

  Future<void> updateEngineCapacity(int id, int capacity) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    final updatedCapacities =
        state.engineCapacities.map((cap) {
          return cap.id == id ? cap.copyWith(capacity: capacity) : cap;
        }).toList();

    final body = EditEngineCapacityBody(
      id: id.toString(),
      capacity: capacity.toString(),
    );
    final response = await _editEngineCapacityUsecase.call(body);
    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (capacity) {
        return {
          emit(
            state.copyWith(
              engineCapacities: updatedCapacities,
              actionStatus: GeneratorsEnginesStatus.loaded,
            ),
          ),
        };
      },
    );
    // emit(
    //   state.copyWith(
    //     engineCapacities: updatedCapacities,
    //     actionStatus: GeneratorsEnginesStatus.loaded,
    //   ),
    // );
    // emit(
    //   state.copyWith(
    //     actionStatus: GeneratorsEnginesStatus.error,
    //     error: e.toString(),
    //   ),
    // );
  }

  Future<void> deleteEngineCapacity(int id) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final response = await _deleteEngineCapacitiesUsecase.call(
      DeleteEngineCapacityBody(ids: [id.toString()]),
    );

    response.fold(
      (failure) {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        );
      },
      (success) {
        emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loaded));
        loadEngineCapacities();
      },
    );
  }

  // Engines Management
  void loadEngines() async {
    emit(state.copyWith(enginesStatus: GeneratorsEnginesStatus.loading));

    final response = await _getEnginesUsecase.call();

    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            enginesStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (engines) {
        emit(
          state.copyWith(
            enginesStatus: GeneratorsEnginesStatus.loaded,
            engines: engines,
          ),
        );
      },
    );
  }

  Future<List<SiteEntity>> loadSites({
    int page = 1,
    String searchQuery = "",
  }) async {
    emit(state.copyWith(sitesStatus: GeneratorsEnginesStatus.loading));
    final body = SearchSitesWithPagination(
      page: page,
      searchQuery: searchQuery,
    );
    final response = await _searchSitesUseCase.call(body: body);

    List<SiteEntity> sites = [];
    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            sitesStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (sitesResponse) {
        sites = sitesResponse.sites;
        emit(
          state.copyWith(
            sitesStatus: GeneratorsEnginesStatus.loaded,
            sites: sitesResponse.sites,
          ),
        );
        log(
          "sites length in the cubit call is: ${sitesResponse.sites.length.toString()}",
        );
      },
    );

    return sites;
  }

  Future<void> addEngine(int brandId, int capacityId) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final body = CreateEngineBody(
      engineBrandId: brandId.toString(),
      engineCapacityId: capacityId.toString(),
    );

    final response = await _createEngineUseCase.call(body);

    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (engine) {
        final updatedEngines = [...state.engines, engine];
        emit(
          state.copyWith(
            engines: updatedEngines,
            actionStatus: GeneratorsEnginesStatus.loaded,
          ),
        );
      },
    );
  }

  Future<void> updateEngine(int id, int brandId, int capacityId) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final brand = state.engineBrands.firstWhere((b) => b.id == brandId);
    final capacity = state.engineCapacities.firstWhere(
      (c) => c.id == capacityId,
    );

    final updatedEngines =
        state.engines.map((engine) {
          return engine.id == id
              ? engine.copyWith(engineBrand: brand, engineCapacity: capacity)
              : engine;
        }).toList();

    final body = EditEngineBody(
      id: id.toString(),
      engineBrandId: brandId.toString(),
      engineCapacityId: capacityId.toString(),
    );

    final response = await _editEngineUseCase.call(body);

    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (engine) {
        emit(
          state.copyWith(
            engines: updatedEngines,
            actionStatus: GeneratorsEnginesStatus.loaded,
          ),
        );
      },
    );
  }

  Future<void> addGenerator({
    required int brandId,
    required int engineId,
    int? siteId,
    required String initialMeter,
  }) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final body = CreateGeneratorBody(
      generatorBrandId: brandId.toString(),
      engineId: engineId.toString(),
      siteId: siteId.toString(),
      initialMeter: initialMeter,
    );

    final response = await _createGeneratorUsecase.call(body);

    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (generator) {
        final updatedGenerators = [...state.generators, generator];
        emit(
          state.copyWith(
            generators: updatedGenerators,
            actionStatus: GeneratorsEnginesStatus.loaded,
          ),
        );
      },
    );

    // try {
    //   final brand = state.generatorBrands.firstWhere((b) => b.id == brandId);
    //   final engine = state.engines.firstWhere((e) => e.id == engineId);
    //   final site = state.sites.firstWhere((s) => s.id == siteId);

    //   final newGenerator = GeneratorEntity(
    //     id: state.generators.length + 1,
    //     brand: brand,
    //     engine: engine,
    //     initalMeter: initialMeter,
    //     site: site,
    //   );
    //   final updatedGenerator = [...state.generators, newGenerator];
    //   emit(
    //     state.copyWith(
    //       generators: updatedGenerator,
    //       actionStatus: GeneratorsEnginesStatus.loaded,
    //     ),
    //   );
    // } catch (e) {
    //   emit(
    //     state.copyWith(
    //       actionStatus: GeneratorsEnginesStatus.error,
    //       error: e.toString(),
    //     ),
    //   );
    // }
  }

  Future<void> updateGenerator({
    required int id,
    // required int brandId,
    // required int engineId,
    int? siteId,
    required String initialMeter,
  }) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    // final brand = state.generatorBrands.firstWhere((b) => b.id == brandId);
    // final engine = state.engines.firstWhere((e) => e.id == engineId);
    final site = state.sites.firstWhere((s) => s.id == siteId);

    final body = EditGeneratorBody(
      id: id.toString(),
      siteId: siteId.toString(),
      initalMeter: initialMeter,
    );
    final response = await _editGeneratorUsecase.call(body);

    response.fold(
      (failure) => {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        ),
      },
      (generator) {
        final updatedGenerator =
            state.generators.map((generator) {
              return generator.id == id
                  ? generator.copyWith(
                    // engine: engine,
                    // brand: brand,
                    site: site,
                    initalMeter: initialMeter,
                  )
                  : generator;
            }).toList();
        emit(
          state.copyWith(
            generators: updatedGenerator,
            actionStatus: GeneratorsEnginesStatus.loaded,
          ),
        );
      },
    );
  }

  Future<void> deleteEngine(int id) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));

    final response = await _deleteEnginesUseCase.call(
      DeleteEngineBody(ids: [id.toString()]),
    );

    response.fold(
      (failure) {
        emit(
          state.copyWith(
            actionStatus: GeneratorsEnginesStatus.error,
            error: failure.errMessage,
          ),
        );
      },
      (success) {
        emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loaded));
        loadEngines();
      },
    );
  }

  void showBrandDialog(
    BuildContext context, {
    required bool isEngine,
    BrandEntity? brand,
  }) {
    brandController.setText(brand?.brand ?? '');
    showDialog(
      context: context,
      builder:
          (dialogContext) =>
              BrandDialog(brand: brand, isEngine: isEngine, cubit: this),
    );
  }

  void showGeneratorDialog(
    BuildContext context, {
    GeneratorEntity? generator,
  }) async {
    showDialog(
      context: context,
      builder:
          (dialogContext) => BlocProvider.value(
            value: this,
            child: GeneratorDialog(
              generator: generator,
              state: state,
              cubit: this,
            ),
          ),
    );
  }

  void showCapacityDialog(
    BuildContext context, {
    EngineCapacityEntity? capacity,
  }) {
    capacityController.setText(capacity?.capacity.toString() ?? '');
    showDialog(
      context: context,
      builder:
          (dialogContext) => CapacityDialog(capacity: capacity, cubit: this),
    );
  }

  void showEngineDialog(BuildContext context, {EngineEntity? engine}) {
    showDialog(
      context: context,
      builder:
          (dialogContext) =>
              EngineDialog(engine: engine, cubit: this, state: state),
    );
  }

  void resetActionStatus() {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.initial));
  }
}

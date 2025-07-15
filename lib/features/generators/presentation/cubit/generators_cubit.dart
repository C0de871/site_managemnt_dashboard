import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/databases/params/body.dart';
import 'package:site_managemnt_dashboard/core/shared/domain/entities/pagination_entity.dart';
import 'package:site_managemnt_dashboard/features/engine_brands/domain/usecases/add_engine_brand_usecase.dart';
import 'package:site_managemnt_dashboard/features/engine_brands/domain/usecases/get_engines_brands_usecase.dart';
import 'package:site_managemnt_dashboard/features/engine_capacities/domain/usecases/add_engine_capacity_usecase.dart';
import 'package:site_managemnt_dashboard/features/engines/domain/usecases/add_engine_usecase.dart';
import 'package:site_managemnt_dashboard/features/engines/domain/usecases/get_engines_usecase.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/usecases/create_generators_usecase.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/usecases/get_generators_usecase.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/dialogs/generator_dialog.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/usecases/get_all_sites_usecase.dart';

import '../../../../core/utils/services/service_locator.dart';
import '../../../engine_brands/domain/entities/brand_entity.dart';
import '../../../engine_capacities/domain/entities/engine_capacity_entity.dart';
import '../../../engine_capacities/domain/usecases/get_engine_capacities_usecase.dart';
import '../../../engines/domain/entities/engine_entity.dart';
import '../../../generator_brand/domain/usecases/add_generator_brand_usecase.dart';
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

  final GetGeneratorsUseCase _getGeneratorsUseCase = getIt();
  final GetEngineBrandsUsecase _getEngineBrandsUsecase = getIt();
  final GetGeneratorBrandsUsecase _getGeneratorBrandsUsecase = getIt();

  final GetEngineCapacitiesUsecase _getEngineCapacitiesUsecase = getIt();
  final GetAllSitesUseCase _getAllSitesUseCase = getIt();

  final AddEngineBrandUsecase _addEngineBrandUsecase = getIt();
  final AddGeneratorBrandUsecase _addGeneratorBrandUsecase = getIt();
  final AddEngineCapacityUsecase _addEngineCapacityUsecase = getIt();
  final CreateEngineUseCase _createEngineUseCase = getIt();
  final CreateGeneratorUsecase _createGeneratorUsecase = getIt();

  final GetEnginesUseCase _getEnginesUsecase = getIt();
  Future<void> fetchGenerators({int page = 1}) async {
    emit(state.copyWith(generatorsStatus: GeneratorsEnginesStatus.loading));
    final response = await _getGeneratorsUseCase.call(page:page);
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

  void updateEngineBrand(int id, String brandName) {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final updatedBrands =
          state.engineBrands.map((brand) {
            return brand.id == id ? brand.copyWith(brand: brandName) : brand;
          }).toList();
      emit(
        state.copyWith(
          engineBrands: updatedBrands,
          actionStatus: GeneratorsEnginesStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteEngineBrand(int id) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final updatedBrands =
          state.engineBrands.where((brand) => brand.id != id).toList();
      emit(
        state.copyWith(
          engineBrands: updatedBrands,
          actionStatus: GeneratorsEnginesStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
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

  void updateGeneratorBrand(int id, String brandName) {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final updatedBrands =
          state.generatorBrands.map((brand) {
            return brand.id == id ? brand.copyWith(brand: brandName) : brand;
          }).toList();
      emit(
        state.copyWith(
          generatorBrands: updatedBrands,
          actionStatus: GeneratorsEnginesStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteGeneratorBrand(int id) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final updatedBrands =
          state.generatorBrands.where((brand) => brand.id != id).toList();
      emit(
        state.copyWith(
          generatorBrands: updatedBrands,
          actionStatus: GeneratorsEnginesStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
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

  void updateEngineCapacity(int id, int capacity) {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final updatedCapacities =
          state.engineCapacities.map((cap) {
            return cap.id == id ? cap.copyWith(capacity: capacity) : cap;
          }).toList();
      emit(
        state.copyWith(
          engineCapacities: updatedCapacities,
          actionStatus: GeneratorsEnginesStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteEngineCapacity(int id) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final updatedCapacities =
          state.engineCapacities.where((cap) => cap.id != id).toList();
      emit(
        state.copyWith(
          engineCapacities: updatedCapacities,
          actionStatus: GeneratorsEnginesStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
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

  Future<List<SiteEntity>> loadSites({int page = 1}) async {
    emit(state.copyWith(sitesStatus: GeneratorsEnginesStatus.loading));
    // await Future.delayed(Duration(seconds: 2));

    final response = await _getAllSitesUseCase.call(page: page);

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

    // try {
    //   final brand = state.engineBrands.firstWhere((b) => b.id == brandId);
    //   final capacity = state.engineCapacities.firstWhere(
    //     (c) => c.id == capacityId,
    //   );

    //   final newEngine = EngineEntity(
    //     id: state.engines.length + 1,
    //     engineBrand: brand,
    //     engineCapacity: capacity,
    //   );
    //   final updatedEngines = [...state.engines, newEngine];
    //   emit(
    //     state.copyWith(
    //       engines: updatedEngines,
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

  void updateEngine(int id, int brandId, int capacityId) {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
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
      emit(
        state.copyWith(
          engines: updatedEngines,
          actionStatus: GeneratorsEnginesStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
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

  void updateGenerator({
    required int id,
    required int brandId,
    required int engineId,
    int? siteId,
    required String initialMeter,
  }) {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final brand = state.generatorBrands.firstWhere((b) => b.id == brandId);
      final engine = state.engines.firstWhere((e) => e.id == engineId);
      final site = state.sites.firstWhere((s) => s.id == siteId);

      final updatedGenerator =
          state.generators.map((generator) {
            return generator.id == id
                ? generator.copyWith(
                  engine: engine,
                  brand: brand,
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
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteEngine(int id) async {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final updatedEngines =
          state.engines.where((engine) => engine.id != id).toList();
      emit(
        state.copyWith(
          engines: updatedEngines,
          actionStatus: GeneratorsEnginesStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          actionStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  void showBrandDialog(
    BuildContext context, {
    required bool isEngine,
    BrandEntity? brand,
  }) {
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
    // loadSites();
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

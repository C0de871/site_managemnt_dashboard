import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/shared/domain/entities/pagination_entity.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/usecases/get_generators_usecase.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/dialogs/generator_dialog.dart';

import '../../../../core/utils/services/service_locator.dart';
import '../../../engine_brands/domain/entities/brand_entity.dart';
import '../../../engine_capacities/domain/entities/engine_capacity_entity.dart';
import '../../../engines/domain/entities/engine_entity.dart';
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
  Future<void> fetchGenerators() async {
    emit(state.copyWith(generatorsStatus: GeneratorsEnginesStatus.loading));
    final response = await _getGeneratorsUseCase.call();
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
  void loadEngineBrands() {
    emit(state.copyWith(engineBrandsStatus: GeneratorsEnginesStatus.loading));
    try {
      // Simulate API call - replace with actual data fetching
      final brands = [
        const BrandEntity(id: 1, brand: 'Caterpillar'),
        const BrandEntity(id: 2, brand: 'Cummins'),
        const BrandEntity(id: 3, brand: 'Perkins'),
      ];
      emit(
        state.copyWith(
          engineBrandsStatus: GeneratorsEnginesStatus.loaded,
          engineBrands: brands,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          engineBrandsStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  void addEngineBrand(String brandName) {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final newBrand = BrandEntity(
        id: state.engineBrands.length + 1,
        brand: brandName,
      );
      final updatedBrands = [...state.engineBrands, newBrand];
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
  void loadGeneratorBrands() {
    emit(
      state.copyWith(generatorBrandsStatus: GeneratorsEnginesStatus.loading),
    );
    try {
      final brands = [
        const BrandEntity(id: 1, brand: 'Stamford'),
        const BrandEntity(id: 2, brand: 'Leroy Somer'),
        const BrandEntity(id: 3, brand: 'Mecc Alte'),
      ];
      emit(
        state.copyWith(
          generatorBrandsStatus: GeneratorsEnginesStatus.loaded,
          generatorBrands: brands,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          generatorBrandsStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  void addGeneratorBrand(String brandName) {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final newBrand = BrandEntity(
        id: state.generatorBrands.length + 1,
        brand: brandName,
      );
      final updatedBrands = [...state.generatorBrands, newBrand];
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
  void loadEngineCapacities() {
    emit(
      state.copyWith(engineCapacitiesStatus: GeneratorsEnginesStatus.loading),
    );
    try {
      final capacities = [
        const EngineCapacityEntity(id: 1, capacity: 100),
        const EngineCapacityEntity(id: 2, capacity: 200),
        const EngineCapacityEntity(id: 3, capacity: 500),
      ];
      emit(
        state.copyWith(
          engineCapacitiesStatus: GeneratorsEnginesStatus.loaded,
          engineCapacities: capacities,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          engineCapacitiesStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  void addEngineCapacity(int capacity) {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final newCapacity = EngineCapacityEntity(
        id: state.engineCapacities.length + 1,
        capacity: capacity,
      );
      final updatedCapacities = [...state.engineCapacities, newCapacity];
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
  void loadEngines() {
    emit(state.copyWith(enginesStatus: GeneratorsEnginesStatus.loading));
    try {
      final engines = [
        EngineEntity(
          id: 1,
          engineBrand: state.engineBrands.first,
          engineCapacity: state.engineCapacities.first,
        ),
      ];
      emit(
        state.copyWith(
          enginesStatus: GeneratorsEnginesStatus.loaded,
          engines: engines,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          enginesStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> loadSites() async {
    emit(state.copyWith(sitesStatus: GeneratorsEnginesStatus.loading));
    await Future.delayed(Duration(seconds: 2));
    try {
      final sites = List<SiteEntity>.generate(
        30,
        (index) => SiteEntity(
          id: index + 1,
          name: 'site $index',
          code: '${index + 1}000',
          longitude: '123.456',
          latitude: '78.910',
        ),
      );

      emit(
        state.copyWith(
          sitesStatus: GeneratorsEnginesStatus.loaded,
          sites: sites,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          sitesStatus: GeneratorsEnginesStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  void addEngine(int brandId, int capacityId) {
    emit(state.copyWith(actionStatus: GeneratorsEnginesStatus.loading));
    try {
      final brand = state.engineBrands.firstWhere((b) => b.id == brandId);
      final capacity = state.engineCapacities.firstWhere(
        (c) => c.id == capacityId,
      );

      final newEngine = EngineEntity(
        id: state.engines.length + 1,
        engineBrand: brand,
        engineCapacity: capacity,
      );
      final updatedEngines = [...state.engines, newEngine];
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

  void addGenerator({
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

      final newGenerator = GeneratorEntity(
        id: state.generators.length + 1,
        brand: brand,
        engine: engine,
        initalMeter: initialMeter,
        site: site,
      );
      final updatedGenerator = [...state.generators, newGenerator];
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
    loadSites();
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

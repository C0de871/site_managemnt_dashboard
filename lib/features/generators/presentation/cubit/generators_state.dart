part of 'generators_cubit.dart';

class GeneratorsEnginesState extends Equatable {
  const GeneratorsEnginesState({
    this.generatorsStatus = GeneratorsEnginesStatus.initial,
    this.generators = const [],
    this.error = '',
    this.actionStatus = GeneratorsEnginesStatus.initial,
    this.selectedGeneratorIds = const {},
    this.engineBrandsStatus = GeneratorsEnginesStatus.initial,
    this.generatorBrandsStatus = GeneratorsEnginesStatus.initial,
    this.engineCapacitiesStatus = GeneratorsEnginesStatus.initial,
    this.enginesStatus = GeneratorsEnginesStatus.initial,
    this.sitesStatus = GeneratorsEnginesStatus.initial,
    this.engineBrands = const [],
    this.generatorBrands = const [],
    this.engineCapacities = const [],
    this.pagination,
    this.engines = const [],
    this.sites = const [],
  });

  final GeneratorsEnginesStatus generatorsStatus;
  final GeneratorsEnginesStatus actionStatus;
  final List<GeneratorEntity> generators;
  final PaginationEntity? pagination;
  final Set<String> selectedGeneratorIds;
  final String error;

  final GeneratorsEnginesStatus engineBrandsStatus;
  final GeneratorsEnginesStatus generatorBrandsStatus;
  final GeneratorsEnginesStatus engineCapacitiesStatus;
  final GeneratorsEnginesStatus enginesStatus;
  final GeneratorsEnginesStatus sitesStatus;

  final List<BrandEntity> engineBrands;
  final List<BrandEntity> generatorBrands;
  final List<EngineCapacityEntity> engineCapacities;
  final List<EngineEntity> engines;
  final List<SiteEntity> sites;

  @override
  List<Object?> get props => [
    generatorsStatus,
    generators,
    error,
    actionStatus,
    selectedGeneratorIds,
    engineBrandsStatus,
    generatorBrandsStatus,
    engineCapacitiesStatus,
    sitesStatus,
    enginesStatus,
    engineBrands,
    generatorBrands,
    engineCapacities,
    engines,
    sites,
    pagination,
  ];

  GeneratorsEnginesState copyWith({
    GeneratorsEnginesStatus? generatorsStatus,
    List<GeneratorEntity>? generators,
    String? error,
    GeneratorsEnginesStatus? actionStatus,
    GeneratorsEnginesStatus? engineStatus,
    Set<String>? selectedGeneratorIds,
    Set<String>? selectedEngineIds,
    int? currentGeneratorEnginesId,
    GeneratorsEnginesStatus? engineBrandsStatus,
    GeneratorsEnginesStatus? generatorBrandsStatus,
    GeneratorsEnginesStatus? engineCapacitiesStatus,
    GeneratorsEnginesStatus? enginesStatus,
    GeneratorsEnginesStatus? sitesStatus,
    List<BrandEntity>? engineBrands,
    List<BrandEntity>? generatorBrands,
    List<EngineCapacityEntity>? engineCapacities,
    List<EngineEntity>? engines,
    List<SiteEntity>? sites,
    PaginationEntity? pagination,
  }) {
    return GeneratorsEnginesState(
      generatorsStatus: generatorsStatus ?? this.generatorsStatus,
      generators: generators ?? this.generators,
      error: error ?? this.error,
      actionStatus: actionStatus ?? this.actionStatus,
      selectedGeneratorIds: selectedGeneratorIds ?? this.selectedGeneratorIds,
      engineBrandsStatus: engineBrandsStatus ?? this.engineBrandsStatus,
      generatorBrandsStatus:
          generatorBrandsStatus ?? this.generatorBrandsStatus,
      engineCapacitiesStatus:
          engineCapacitiesStatus ?? this.engineCapacitiesStatus,
      enginesStatus: enginesStatus ?? this.enginesStatus,
      sitesStatus: sitesStatus ?? this.sitesStatus,
      engineBrands: engineBrands ?? this.engineBrands,
      generatorBrands: generatorBrands ?? this.generatorBrands,
      engineCapacities: engineCapacities ?? this.engineCapacities,
      engines: engines ?? this.engines,
      sites: sites ?? this.sites,
      pagination: pagination ?? this.pagination,
    );
  }
}

enum GeneratorsEnginesStatus { initial, loading, loaded, error }

extension GeneratorsStatusX on GeneratorsEnginesStatus {
  bool get isInitial => this == GeneratorsEnginesStatus.initial;
  bool get isLoading => this == GeneratorsEnginesStatus.loading;
  bool get isLoaded => this == GeneratorsEnginesStatus.loaded;
  bool get isError => this == GeneratorsEnginesStatus.error;
}

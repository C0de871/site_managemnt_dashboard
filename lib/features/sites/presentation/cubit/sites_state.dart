part of 'sites_cubit.dart';

class SitesState extends Equatable {
  const SitesState({
    this.sitesStatus = SitesStatus.initial,
    this.sitesResponseEntity,
    this.error = '',
    this.actionStatus = SitesStatus.initial,
    this.generatorStatus = SitesStatus.initial,
    this.selectedSiteIds = const {},
    this.selectedGeneratorIds = const {},
    this.lastPageNumber = 1,
    this.currentSiteGeneratorsId = -1,
    this.freeGenerators = const [],
    this.selectedGenerators = const [],
    this.freeGeneratorsStatus = GeneratorsEnginesStatus.initial,
  });

  final SitesStatus sitesStatus;
  final SitesStatus actionStatus;
  final SitesStatus generatorStatus;
  final SitesResponseEntity? sitesResponseEntity;
  final Set<String> selectedSiteIds;
  final Set<String> selectedGeneratorIds;
  final String error;
  final int currentSiteGeneratorsId;
  final int lastPageNumber;

  final List<GeneratorEntity> freeGenerators;
  final List<GeneratorEntity> selectedGenerators;
  final GeneratorsEnginesStatus freeGeneratorsStatus;

  @override
  List<Object?> get props => [
    sitesStatus,
    sitesResponseEntity,
    error,
    actionStatus,
    generatorStatus,
    selectedSiteIds,
    selectedGeneratorIds,
    lastPageNumber,
    currentSiteGeneratorsId,
    freeGenerators,
    freeGeneratorsStatus,
    selectedGenerators,
  ];

  SitesState copyWith({
    SitesStatus? sitesStatus,
    SitesResponseEntity? sitesResponseEntity,
    String? error,
    SitesStatus? actionStatus,
    SitesStatus? generatorStatus,
    Set<String>? selectedSiteIds,
    Set<String>? selectedGeneratorIds,
    int? currentSiteGeneratorsId,
    int? lastPageNumber,
    List<GeneratorEntity>? freeGenerators,
    GeneratorsEnginesStatus? freeGeneratorsStatus,
    List<GeneratorEntity>? selectedGenerators,
  }) {
    return SitesState(
      sitesStatus: sitesStatus ?? this.sitesStatus,
      sitesResponseEntity: sitesResponseEntity ?? this.sitesResponseEntity,
      error: error ?? this.error,
      actionStatus: actionStatus ?? this.actionStatus,
      generatorStatus: generatorStatus ?? this.generatorStatus,
      selectedSiteIds: selectedSiteIds ?? this.selectedSiteIds,
      selectedGeneratorIds: selectedGeneratorIds ?? this.selectedGeneratorIds,
      lastPageNumber: lastPageNumber ?? this.lastPageNumber,
      currentSiteGeneratorsId:
          currentSiteGeneratorsId ?? this.currentSiteGeneratorsId,
      freeGenerators: freeGenerators ?? this.freeGenerators,
      freeGeneratorsStatus: freeGeneratorsStatus ?? this.freeGeneratorsStatus,
      selectedGenerators: selectedGenerators ?? this.selectedGenerators,
    );
  }
}

enum SitesStatus { initial, loading, loaded, error }

extension SitesStatusX on SitesStatus {
  bool get isInitial => this == SitesStatus.initial;
  bool get isLoading => this == SitesStatus.loading;
  bool get isLoaded => this == SitesStatus.loaded;
  bool get isError => this == SitesStatus.error;
}

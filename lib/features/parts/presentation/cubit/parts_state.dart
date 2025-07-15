part of 'parts_cubit.dart';

class PartsState extends Equatable {
  const PartsState({
    this.partsStatus = PartsStatus.initial,
    this.parts = const [],
    this.error = '',
    this.actionStatus = PartsStatus.initial,
    this.engineStatus = AvailableEnginesStatus.initial,
    this.selectedPartIds = const {},
    this.selectedEngineIds = const {},
    this.availableEngines = const [],
    this.currentPartEnginesId = -1,
    this.pagination = const PaginationEntity(),
  });

  final PartsStatus partsStatus;
  final PartsStatus actionStatus;
  final AvailableEnginesStatus engineStatus;
  final List<PartEntity> parts;
  final List<EngineEntity> availableEngines;
  final Set<String> selectedPartIds;
  final Set<String> selectedEngineIds;
  final String error;
  final int currentPartEnginesId;

  final PaginationEntity pagination;

  @override
  List<Object?> get props => [
    partsStatus,
    parts,
    error,
    actionStatus,
    engineStatus,
    selectedPartIds,
    selectedEngineIds,
    currentPartEnginesId,
    availableEngines,
    pagination,
  ];

  PartsState copyWith({
    PartsStatus? partsStatus,
    List<PartEntity>? parts,
    List<EngineEntity>? availableEngines,
    String? error,
    PartsStatus? actionStatus,
    AvailableEnginesStatus? engineStatus,
    Set<String>? selectedPartIds,
    Set<String>? selectedEngineIds,
    int? currentPartEnginesId,
    PaginationEntity? pagination,
  }) {
    return PartsState(
      partsStatus: partsStatus ?? this.partsStatus,
      parts: parts ?? this.parts,
      availableEngines: availableEngines ?? this.availableEngines,
      error: error ?? this.error,
      actionStatus: actionStatus ?? this.actionStatus,
      engineStatus: engineStatus ?? this.engineStatus,
      selectedPartIds: selectedPartIds ?? this.selectedPartIds,
      selectedEngineIds: selectedEngineIds ?? this.selectedEngineIds,
      currentPartEnginesId: currentPartEnginesId ?? this.currentPartEnginesId,
      pagination: pagination ?? this.pagination,
    );
  }
}

enum PartsStatus { initial, loading, loaded, error }

extension PartsStatusX on PartsStatus {
  bool get isInitial => this == PartsStatus.initial;
  bool get isLoading => this == PartsStatus.loading;
  bool get isLoaded => this == PartsStatus.loaded;
  bool get isError => this == PartsStatus.error;
}

enum AvailableEnginesStatus { initial, loading, loaded, error }

extension AvailableEnginesStatusX on AvailableEnginesStatus {
  bool get isInitial => this == AvailableEnginesStatus.initial;
  bool get isLoading => this == AvailableEnginesStatus.loading;
  bool get isLoaded => this == AvailableEnginesStatus.loaded;
  bool get isError => this == AvailableEnginesStatus.error;
}

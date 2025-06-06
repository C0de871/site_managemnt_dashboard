part of 'parts_cubit.dart';

class PartsState extends Equatable {
  const PartsState({
    this.partsStatus = PartsStatus.initial,
    this.parts = const [],
    this.error = '',
    this.actionStatus = PartsStatus.initial,
    this.engineStatus = PartsStatus.initial,
    this.selectedPartIds = const {},
    this.selectedEngineIds = const {},
    this.availableEngines = const [],
    this.currentPartEnginesId,
  });

  final PartsStatus partsStatus;
  final PartsStatus actionStatus;
  final PartsStatus engineStatus;
  final List<PartEntity> parts;
  final List<EngineEntity> availableEngines;
  final Set<String> selectedPartIds;
  final Set<String> selectedEngineIds;
  final String error;
  final int? currentPartEnginesId;

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
  ];

  PartsState copyWith({
    PartsStatus? partsStatus,
    List<PartEntity>? parts,
    List<EngineEntity>? availableEngines,
    String? error,
    PartsStatus? actionStatus,
    PartsStatus? engineStatus,
    Set<String>? selectedPartIds,
    Set<String>? selectedEngineIds,
    int? currentPartEnginesId,
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
      currentPartEnginesId: currentPartEnginesId,
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

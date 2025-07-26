import 'package:equatable/equatable.dart';

import '../../../engines/domain/entities/engine_entity.dart';

class PartEntity extends Equatable {
  final int id;
  final String? code;
  final String name;
  final bool? isGeneral;
  final List<EngineEntity> engines;
  final int? quantity;
  final int? faultyQuantity;
  final bool? isFaulty;
  final String? note;
  final DateTime? lastReplacementDate;
  final int? generatorHoursAtLastReplacement;

  String get fomattedLastReplacementDate {
    if (lastReplacementDate == null) {
      return "No previous replacement";
    }
    return '${lastReplacementDate!.day}/${lastReplacementDate!.month}/${lastReplacementDate!.year}';
  }

  const PartEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.isGeneral,
    required this.engines,
    required this.quantity,
    required this.faultyQuantity,
    required this.isFaulty,
    required this.note,
    required this.lastReplacementDate,
    required this.generatorHoursAtLastReplacement,
  });

  @override
  List<Object?> get props => [
    id,
    code,
    name,
    isGeneral,
    engines,
    quantity,
    faultyQuantity,
    isFaulty,
    note,
    lastReplacementDate,
    generatorHoursAtLastReplacement,
  ];

  PartEntity copyWith({
    int? id,
    String? code,
    String? name,
    bool? isGeneral,
    List<EngineEntity>? engines,
    int? quantity,
    int? faultyQuantity,
    bool? isFaulty,
    String? note,
    DateTime? lastReplacementDate,
    int? generatorHoursAtLastReplacement,
  }) {
    return PartEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      isGeneral: isGeneral ?? this.isGeneral,
      engines: engines ?? this.engines,
      quantity: quantity ?? this.quantity,
      faultyQuantity: faultyQuantity ?? this.faultyQuantity,
      isFaulty: isFaulty ?? this.isFaulty,
      note: note ?? this.note,
      lastReplacementDate: lastReplacementDate ?? this.lastReplacementDate,
      generatorHoursAtLastReplacement:
          generatorHoursAtLastReplacement ?? this.generatorHoursAtLastReplacement,
    );
  }
}

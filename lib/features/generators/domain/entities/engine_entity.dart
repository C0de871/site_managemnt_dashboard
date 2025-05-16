import 'package:equatable/equatable.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/entities/engine_brand_entity.dart';

import 'engine_capacity_entity.dart';

class EngineEntity extends Equatable {
  final int id;
  final EngineBrandEntity engineBrand;
  final EngineCapacityEntity engineCapacity;

  const EngineEntity({
    required this.id,
    required this.engineBrand,
    required this.engineCapacity,
  });

  @override
  List<Object?> get props => [id, engineBrand, engineCapacity];

  EngineEntity copyWith({
    int? id,
    EngineBrandEntity? engineBrand,
    EngineCapacityEntity? engineCapacity,
  }) {
    return EngineEntity(
      id: id ?? this.id,
      engineBrand: engineBrand ?? this.engineBrand,
      engineCapacity: engineCapacity ?? this.engineCapacity,
    );
  }
}

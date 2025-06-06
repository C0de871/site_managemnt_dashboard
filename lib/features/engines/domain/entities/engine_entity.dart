import 'package:equatable/equatable.dart';

import '../../../engine_brands/domain/entities/brand_entity.dart';
import '../../../engine_capacities/domain/entities/engine_capacity_entity.dart';

class EngineEntity extends Equatable {
  final int id;
  final BrandEntity engineBrand;
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
    BrandEntity? engineBrand,
    EngineCapacityEntity? engineCapacity,
  }) {
    return EngineEntity(
      id: id ?? this.id,
      engineBrand: engineBrand ?? this.engineBrand,
      engineCapacity: engineCapacity ?? this.engineCapacity,
    );
  }
}

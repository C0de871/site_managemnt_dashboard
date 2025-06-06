import '../../domain/entities/engine_capacity_entity.dart';

class EngineCapacityModel extends EngineCapacityEntity {
  static const String idKey = 'id';
  static const String capacityKey = 'capacity';

  const EngineCapacityModel({required super.id, required super.capacity});

  factory EngineCapacityModel.fromJson(Map<String, dynamic> json) {
    return EngineCapacityModel(
      id: json[idKey] as int,
      capacity: json[capacityKey] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {idKey: id, capacityKey: capacity};
  }
}

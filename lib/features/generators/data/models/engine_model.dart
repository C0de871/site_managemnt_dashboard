import '../../domain/entities/engine_entity.dart';
import 'engine_brand_model.dart';
import 'generator_brand_model.dart';
import 'engine_capacity_model.dart';

class EngineModel extends EngineEntity {
  static const String idKey = 'id';
  static const String engineBrandKey = 'engine_brand';
  static const String engineCapacityKey = 'engine_capacity';

  const EngineModel({
    required super.id,
    required super.engineBrand,
    required super.engineCapacity,
  });

  factory EngineModel.fromJson(Map<String, dynamic> json) {
    return EngineModel(
      id: json[idKey] as int,
      engineBrand: EngineBrandModel.fromJson(
        json[engineBrandKey] as Map<String, dynamic>,
      ),
      engineCapacity: EngineCapacityModel.fromJson(
        json[engineCapacityKey] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      idKey: id,
      engineBrandKey: (engineBrand as GeneratorBrandModel).toJson(),
      engineCapacityKey: (engineCapacity as EngineCapacityModel).toJson(),
    };
  }
}

import '../../domain/entities/part_entity.dart';
import '../../../generators/data/models/engine_model.dart';

class PartModel extends PartEntity {
  static const String idKey = 'id';
  static const String codeKey = 'code';
  static const String nameKey = 'name';
  static const String isGeneralKey = 'is_general';
  static const String enginesKey = 'engines';

  const PartModel({
    required super.id,
    required super.code,
    required super.name,
    required super.isGeneral,
    required super.engines,
  });

  factory PartModel.fromJson(Map<String, dynamic> json) {
    return PartModel(
      id: json[idKey],
      code: json[codeKey],
      name: json[nameKey],
      isGeneral: json[isGeneralKey],
      engines:
          (json[enginesKey] as List)
              .map((engine) => EngineModel.fromJson(engine))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      idKey: id,
      codeKey: code,
      nameKey: name,
      isGeneralKey: isGeneral,
      enginesKey:
          engines.map((engine) => (engine as EngineModel).toJson()).toList(),
    };
  }
}

import '../../../engines/data/models/engine_model.dart';
import '../../domain/entities/part_entity.dart';

class PartModel extends PartEntity {
  static const String idKey = 'id';
  static const String codeKey = 'code';
  static const String nameKey = 'name';
  static const String isGeneralKey = 'is_general';
  static const String enginesKey = 'engines';
  static const String quantityKey = 'quantity';
  static const String faultyQuantityKey = 'faulty_quantity';
  static const String noteKey = 'note';
  static const String isFaultyKey = 'is_faulty';

  const PartModel({
    required super.id,
    super.code,
    required super.name,
    super.isGeneral,
    required super.engines,
    super.quantity,
    super.faultyQuantity,
    super.isFaulty,
    super.note,
  });

  factory PartModel.fromJson(Map<String, dynamic> json) {
    return PartModel(
      id: json[idKey],
      code: json[codeKey],
      name: json[nameKey],
      isGeneral: json[isGeneralKey] == "1" ? true : false,
      engines:
          (json[enginesKey] as List?)
              ?.map((engine) => EngineModel.fromJson(engine))
              .toList() ??
          [],
      quantity: json[quantityKey],
      faultyQuantity:
          json[faultyQuantityKey] == null
              ? 0
              : int.tryParse(json[faultyQuantityKey]) ?? 0,
      isFaulty: json[isFaultyKey] ?? false,
      note: json[noteKey],
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

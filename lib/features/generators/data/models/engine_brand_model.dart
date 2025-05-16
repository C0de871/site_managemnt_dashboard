 import '../../domain/entities/engine_brand_entity.dart';

class EngineBrandModel extends EngineBrandEntity {
  static const String idKey = 'id';
  static const String brandKey = 'brand';

  const EngineBrandModel({
    required super.id,
    required super.brand,
  });

  factory EngineBrandModel.fromJson(Map<String, dynamic> json) {
    return EngineBrandModel(
      id: json[idKey] as int,
      brand: json[brandKey] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      idKey: id,
      brandKey: brand,
    };
  }
}
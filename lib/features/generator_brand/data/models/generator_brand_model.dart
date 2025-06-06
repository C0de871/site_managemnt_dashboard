import '../../domain/entities/generator_brand_entity.dart';

class GeneratorBrandModel extends GeneratorBrandEntity {
  static const String idKey = 'id';
  static const String brandKey = 'brand';

  const GeneratorBrandModel({required super.id, required super.brand});

  factory GeneratorBrandModel.fromJson(Map<String, dynamic> json) {
    return GeneratorBrandModel(
      id: json[idKey] as int,
      brand: json[brandKey] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {idKey: id, brandKey: brand};
  }
}


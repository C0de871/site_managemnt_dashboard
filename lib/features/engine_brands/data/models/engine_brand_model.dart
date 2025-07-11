import '../../domain/entities/brand_entity.dart';

class EngineBrandModel extends BrandEntity {
  static const String idKey = 'id';
  static const String brandKey = 'brand';

  const EngineBrandModel({required super.id, required super.brand});

  factory EngineBrandModel.fromJson(Map<String, dynamic> json) {
    return EngineBrandModel(
      id: json[idKey] as int,
      brand: json[brandKey] ?? json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {idKey: id, brandKey: brand};
  }
}

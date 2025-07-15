import '../../domain/entities/brand_entity.dart';

class BrandModel extends BrandEntity {
  static const String idKey = 'id';
  static const String brandKey = 'brand';

  const BrandModel({required super.id, required super.brand});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json[idKey] as int,
      brand: json[brandKey] ?? json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {idKey: id, brandKey: brand};
  }
}

import '../../../generators/data/models/generator_model.dart';
import '../../domain/entities/sites_entity.dart';

class SitesModel extends SiteEntity {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String codeKey = 'code';
  static const String longitudeKey = 'longitude';
  static const String latitudeKey = 'latitude';
  static const String generatorsKey = 'generators';

  const SitesModel({
    required super.id,
    required super.name,
    required super.code,
    required super.longitude,
    required super.latitude,
    super.generators,
  });

  factory SitesModel.fromJson(Map<String, dynamic> json) {
    return SitesModel(
      id: json[idKey] as int,
      name: json[nameKey] as String,
      code: json[codeKey] as String,
      longitude: json[longitudeKey] as String,
      latitude: json[latitudeKey] as String,
      generators:
          (json[generatorsKey] as List)
              .map((e) => GeneratorModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      idKey: id,
      nameKey: name,
      codeKey: code,
      longitudeKey: longitude,
      latitudeKey: latitude,
      generatorsKey:
          generators?.map((e) => (e as GeneratorModel).toJson()).toList(),
    };
  }
}

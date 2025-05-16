import '../../domain/entities/sites_entity.dart';

class SitesModel extends SitesEntity {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String codeKey = 'code';

  const SitesModel({
    required super.id,
    required super.name,
    required super.code,
  });

  factory SitesModel.fromJson(Map<String, dynamic> json) {
    return SitesModel(
      id: json[idKey] as int,
      name: json[nameKey] as String,
      code: json[codeKey] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {idKey: id, nameKey: name, codeKey: code};
  }
}

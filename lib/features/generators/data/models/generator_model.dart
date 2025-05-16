import '../../../sites/data/models/sites_model.dart';
import '../../domain/entities/generator_entity.dart';
import 'engine_model.dart';

class GeneratorModel extends GeneratorEntity {
  static const String idKey = 'id';
  static const String brandKey = 'brand';
  static const String engineKey = 'engine';
  static const String initalMeterKey = 'inital_meter';
  static const String siteKey = 'site';

  const GeneratorModel({
    required super.id,
    required super.brand,
    required super.engine,
    required super.initalMeter,
    required super.site,
  });

  factory GeneratorModel.fromJson(Map<String, dynamic> json) {
    return GeneratorModel(
      id: json[idKey] as int,
      brand: json[brandKey] as String,
      engine: EngineModel.fromJson(json[engineKey] as Map<String, dynamic>),
      initalMeter: json[initalMeterKey] as String,
      site: SitesModel.fromJson(json[siteKey] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      idKey: id,
      brandKey: brand,
      engineKey: (engine as EngineModel).toJson(),
      initalMeterKey: initalMeter,
      siteKey: (site as SitesModel).toJson(),
    };
  }
}

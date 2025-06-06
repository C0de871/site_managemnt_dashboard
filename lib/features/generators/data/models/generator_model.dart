import '../../../engine_brands/data/models/engine_brand_model.dart';
import '../../../engines/data/models/engine_model.dart';
import '../../../sites/data/models/sites_model.dart';
import '../../domain/entities/generator_entity.dart';

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
    super.site,
  });

  factory GeneratorModel.fromJson(Map<String, dynamic> json) {
    return GeneratorModel(
      id: json[idKey] as int,
      brand: EngineBrandModel.fromJson(json[brandKey] as Map<String, dynamic>),
      engine: EngineModel.fromJson(json[engineKey] as Map<String, dynamic>),
      initalMeter: json[initalMeterKey] as String,
      site: SitesModel.fromJson(json[siteKey] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      idKey: id,
      brandKey: (brand as EngineBrandModel).toJson(),
      engineKey: (engine as EngineModel).toJson(),
      initalMeterKey: initalMeter,
      siteKey: (site as SitesModel).toJson(),
    };
  }
}

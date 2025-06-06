import 'package:equatable/equatable.dart';
import '../../../engine_brands/domain/entities/brand_entity.dart';
import '../../../engines/domain/entities/engine_entity.dart';
import '../../../sites/domain/entities/sites_entity.dart';

class GeneratorEntity extends Equatable {
  final int id;
  final BrandEntity brand;
  final EngineEntity engine;
  final String initalMeter;
  final SiteEntity? site;

  const GeneratorEntity({
    required this.id,
    required this.brand,
    required this.engine,
    required this.initalMeter,
    this.site,
  });

  @override
  List<Object?> get props => [id, brand, engine, initalMeter, site];

  GeneratorEntity copyWith({
    int? id,
    BrandEntity? brand,
    EngineEntity? engine,
    String? initalMeter,
    SiteEntity? site,
  }) {
    return GeneratorEntity(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      engine: engine ?? this.engine,
      initalMeter: initalMeter ?? this.initalMeter,
      site: site ?? this.site,
    );
  }
}

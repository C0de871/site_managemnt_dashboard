import 'package:equatable/equatable.dart';
import '../../../sites/domain/entities/sites_entity.dart';
import 'engine_entity.dart';

class GeneratorEntity extends Equatable {
  final int id;
  final String brand;
  final EngineEntity engine;
  final String initalMeter;
  final SitesEntity site;

  const GeneratorEntity({
    required this.id,
    required this.brand,
    required this.engine,
    required this.initalMeter,
    required this.site,
  });

  @override
  List<Object?> get props => [id, brand, engine, initalMeter, site];

  GeneratorEntity copyWith({
    int? id,
    String? brand,
    EngineEntity? engine,
    String? initalMeter,
    SitesEntity? site,
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

import 'package:equatable/equatable.dart';

import '../../../generators/domain/entities/generator_entity.dart';

class SiteEntity extends Equatable {
  final int id;
  final String name;
  final String code;
  final String longitude;
  final String latitude;
  final List<GeneratorEntity>? generators;

  const SiteEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.longitude,
    required this.latitude,
    this.generators,
  });

  @override
  List<Object?> get props => [id, name, code, longitude, latitude, generators];

  SiteEntity copyWith({
    int? id,
    String? name,
    String? code,
    String? longitude,
    String? latitude,
    List<GeneratorEntity>? generators,
  }) {
    return SiteEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      generators: generators ?? this.generators,
    );
  }
}

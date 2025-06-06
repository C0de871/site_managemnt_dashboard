import 'package:equatable/equatable.dart';

import '../../../engines/domain/entities/engine_entity.dart';


class PartEntity extends Equatable {
  final int id;
  final String code;
  final String name;
  final bool isGeneral;
  final List<EngineEntity> engines;

  const PartEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.isGeneral,
    required this.engines,
  });

  @override
  List<Object?> get props => [id, code, name, isGeneral, engines];
}
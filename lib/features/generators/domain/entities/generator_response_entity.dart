import 'package:site_managemnt_dashboard/core/shared/domain/entities/pagination_entity.dart';

import 'generator_entity.dart';

class GeneratorResponseEntity {
  final List<GeneratorEntity> generators;
  final PaginationEntity? pagination;
  GeneratorResponseEntity({required this.generators, this.pagination});
}

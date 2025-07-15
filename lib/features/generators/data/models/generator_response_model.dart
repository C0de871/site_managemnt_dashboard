import 'package:site_managemnt_dashboard/core/databases/api/end_points.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/entities/generator_response_entity.dart';

import '../../../../core/shared/data/models/pagination_model.dart';
import 'generator_model.dart';

class GeneratorResponseModel extends GeneratorResponseEntity {
  GeneratorResponseModel({required super.generators, super.pagination});

  factory GeneratorResponseModel.fromJson(Map<String, dynamic> json) {
    final paginationMap = {
      ApiKey.currentPage: json[ApiKey.currentPage],
      ApiKey.totalItems: json[ApiKey.totalItems],
      ApiKey.currentItemsCount: json[ApiKey.currentItemsCount],
    };
    return GeneratorResponseModel(
      generators:
          (json[ApiKey.data] as List?)?.map((generator) {
            return GeneratorModel.fromJson(generator);
          }).toList() ??
          [],
      pagination: PaginationModel.fromJson(paginationMap),
    );
  }
}

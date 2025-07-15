import 'package:site_managemnt_dashboard/core/databases/api/end_points.dart';
import 'package:site_managemnt_dashboard/features/parts/data/models/part_model.dart';
import 'package:site_managemnt_dashboard/features/parts/domain/entities/part_response_entity.dart';

import '../../../../core/shared/data/models/pagination_model.dart';
import '../../domain/entities/part_entity.dart';

class PartResponseModel extends PartResponseEntity {
  const PartResponseModel({required super.parts, super.pagination});

  //from and to json
  factory PartResponseModel.fromJson(Map<String, dynamic> json) {
    final paginationMap = {
      ApiKey.currentPage: json[ApiKey.currentPage],
      ApiKey.totalItems: json[ApiKey.totalItems],
      ApiKey.currentItemsCount: json[ApiKey.currentItemsCount],
    };
    return PartResponseModel(
      parts:
          (json[ApiKey.data] as List)
              .map((e) => PartModel.fromJson(e))
              .toList(),
      pagination: PaginationModel.fromJson(paginationMap),
    );
  }

  Map<String, dynamic> toJson() => {
    ApiKey.data: parts.map((e) => (e as PartModel).toJson()).toList(),

    //todo: tell abdullah to convert these to sub map and i should so...
    ApiKey.currentPage: pagination?.currentPage,
    ApiKey.totalItems: pagination?.totalItemsCount,
    ApiKey.currentItemsCount: pagination?.currentItemsCount,
  };
}

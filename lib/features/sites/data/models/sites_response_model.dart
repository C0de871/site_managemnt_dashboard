import 'dart:developer';

import 'package:site_managemnt_dashboard/core/databases/api/end_points.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/entities/sites_response_entity.dart';

import '../../../../core/shared/data/models/pagination_model.dart';
import 'sites_model.dart';

class SitesResponseModel extends SitesResponseEntity {
  const SitesResponseModel({required super.sites, required super.pagination});

  //tomap
  factory SitesResponseModel.fromJson(Map<String, dynamic> json) {
    final paginationMap = {
      ApiKey.currentPage: json[ApiKey.currentPage],
      ApiKey.totalItems: json[ApiKey.totalItems],
      ApiKey.currentItemsCount: json[ApiKey.currentItemsCount],
    };
    return SitesResponseModel(
      sites:
          (json[ApiKey.data] as List)
              .map((site) => SitesModel.fromJson(site))
              .toList(),
      pagination: PaginationModel.fromJson(paginationMap),
    );
  }
}

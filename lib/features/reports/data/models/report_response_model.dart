import 'package:site_managemnt_dashboard/features/reports/domain/entities/report_response_entity.dart';

import '../../../../core/databases/api/end_points.dart';
import '../../../../core/shared/data/models/pagination_model.dart';
import 'report_model.dart';

class ReportResponseModel extends ReportResponseEntity {
  const ReportResponseModel({
    required super.reports,
    required super.pagination,
  });

  factory ReportResponseModel.fromJson(Map<String, dynamic> json) {
    final paginationMap = {
      ApiKey.currentPage: json[ApiKey.currentPage],
      ApiKey.totalItems: json[ApiKey.totalItems],
      ApiKey.currentItemsCount: json[ApiKey.currentItemsCount],
    };
    return ReportResponseModel(
      reports:
          (json[ApiKey.data] as List)
              .map((e) => ReportModel.fromJson(e))
              .toList(),
      pagination: PaginationModel.fromJson(paginationMap),
    );
  }
}

import 'package:site_managemnt_dashboard/features/reports/data/models/report_response_model.dart';

import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/secure_storage_helper.dart';

class ReportsRemoteDataSource {
  final ApiConsumer api;
  final SecureStorageHelper cacheHelper;
  ReportsRemoteDataSource({required this.api, required this.cacheHelper});

  Future<ReportResponseModel> getReports() async {
    final response = await api.get(EndPoints.getReports);
    return ReportResponseModel.fromJson(response);
  }
}

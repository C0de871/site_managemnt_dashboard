import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/secure_storage_helper.dart';
import '../../../../core/databases/params/body.dart';
import '../../../../core/shared/data/response_model.dart';
import '../models/report_model.dart';

class ReportsRemoteDataSource {
  final ApiConsumer api;
  final SecureStorageHelper cacheHelper;
  ReportsRemoteDataSource({required this.api, required this.cacheHelper});

  Future<ApiResponse<List<ReportModel>>> getReports() async {
    final response = await api.get(EndPoints.getReports);
    return ApiResponse<List<ReportModel>>.fromJson(
      response,
      (json) => (json as List).map((e) => ReportModel.fromJson(e)).toList(),
    );
  }

}

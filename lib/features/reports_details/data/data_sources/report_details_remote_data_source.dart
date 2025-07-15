import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/secure_storage_helper.dart';
import '../../../../core/databases/params/body.dart';
import '../../../../core/shared/data/response_model.dart';
import '../../data/models/report_details_model.dart';

class ReportDetailsRemoteDataSource {
  final ApiConsumer api;
  final SecureStorageHelper cacheHelper;
  ReportDetailsRemoteDataSource({required this.api, required this.cacheHelper});

  Future<ApiResponse<ReportDetailsModel>> getReportDetailsById(
    GetReportByIDBody body,
  ) async {
    final response = await api.get(
      "${EndPoints.getReportDetailsById}/${body.id}",
      data: body.toMap(),
    );
    return ApiResponse<ReportDetailsModel>.fromJson(
      response,
      (json) => ReportDetailsModel.fromJson(json),
    );
  }

  // Future<ApiResponse<ReportDetailsModel>> addReport(AddReportBody body) async {
  //   final response = await api.post(EndPoints.addReport, data: body.toMap());
  //   return ApiResponse<ReportDetailsModel>.fromJson(
  //     response,
  //     (json) => ReportDetailsModel.fromJson(json),
  //   );
  // }

  // Future<ApiResponse<ReportDetailsModel>> editReport(
  //   EditReportBody body,
  // ) async {
  //   final response = await api.put(EndPoints.editReport, data: body.toMap());
  //   return ApiResponse<ReportDetailsModel>.fromJson(
  //     response,
  //     (json) => ReportDetailsModel.fromJson(json),
  //   );
  // }

  // Future<ApiResponse<void>> deleteReport(DeleteReportBody body) async {
  //   final response = await api.delete(
  //     EndPoints.deleteReport,
  //     data: body.toMap(),
  //   );
  //   return ApiResponse<void>.fromJson(response, (json) => json);
  // }
}

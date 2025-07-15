import 'dart:js_interop';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:site_managemnt_dashboard/features/reports/data/models/report_response_model.dart';
import 'package:web/web.dart' as web;

import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/secure_storage_helper.dart';
import '../../../../core/databases/params/body.dart';

class ReportsRemoteDataSource {
  final ApiConsumer api;
  final SecureStorageHelper cacheHelper;
  ReportsRemoteDataSource({required this.api, required this.cacheHelper});

  Future<ReportResponseModel> getReports({required int page}) async {
    final response = await api.get(
      EndPoints.getReports,
      queryParameters: {"page": page},
    );
    return ReportResponseModel.fromJson(response);
  }

  Future<void> exportReports({required ExportReportsBody body}) async {
    final response = await api.post(
      EndPoints.exportReports,
      data: body.toMap(),
      responseType: ResponseType.bytes,
    );

    final bytes = response as Uint8List;

    // Generate filename with timestamp
    final timestamp = DateTime.now()
        .toIso8601String()
        .substring(0, 19)
        .replaceAll(':', '-');
    final filename = "sites_export_$timestamp.xlsx";

    _downloadBinaryFile(
      bytes,
      filename,
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    );
  }

  void _downloadBinaryFile(
    Uint8List bytes,
    String filename, [
    String? mimeType,
  ]) {
    final blob = web.Blob(
      [bytes.toJS].toJS,
      web.BlobPropertyBag(type: mimeType ?? 'application/octet-stream'),
    );
    final url = web.URL.createObjectURL(blob);

    final anchor =
        web.HTMLAnchorElement()
          ..href = url
          ..download = filename
          ..style.display = 'none'; // Hide the anchor element

    // Append to body, click, then remove
    web.document.body?.appendChild(anchor);
    anchor.click();
    web.document.body?.removeChild(anchor);

    web.URL.revokeObjectURL(url);
  }
}

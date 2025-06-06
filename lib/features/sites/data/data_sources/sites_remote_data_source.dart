import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/secure_storage_helper.dart';
import '../../../../core/databases/params/body.dart';
import '../../../../core/shared/data/response_model.dart';
import '../models/sites_model.dart';

class SitesRemoteDataSource {
  final ApiConsumer api;
  final SecureStorageHelper cacheHelper;
  SitesRemoteDataSource({required this.api, required this.cacheHelper});

  Future<ApiResponse<List<SitesModel>>> getSites() async {
    final response = await api.get(EndPoints.getSites);
    return ApiResponse<List<SitesModel>>.fromJson(
      response,
      (json) => (json as List).map((e) => SitesModel.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<SitesModel>> addSite(AddSiteBody body) async {
    final response = await api.post(EndPoints.addSite, data: body.toMap());
    return ApiResponse<SitesModel>.fromJson(
      response,
      (json) => SitesModel.fromJson(json),
    );
  }

  Future<ApiResponse<SitesModel>> editSite(EditSiteBody body) async {
    final response = await api.put(EndPoints.editSite, data: body.toMap());
    return ApiResponse<SitesModel>.fromJson(
      response,
      (json) => SitesModel.fromJson(json),
    );
  }

  Future<ApiResponse<void>> deleteSite(DeleteSiteBody body) async {
    final response = await api.delete(EndPoints.deleteSite, data: body.toMap());
    return ApiResponse<void>.fromJson(response, (json) => json);
  }
}

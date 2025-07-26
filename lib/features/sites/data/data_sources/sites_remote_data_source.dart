import 'package:site_managemnt_dashboard/features/sites/data/models/sites_response_model.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/entities/sites_response_entity.dart';

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

  Future<SitesResponseModel> getSites({required int page}) async {
    final response = await api.get("${EndPoints.getSites}/?page=$page");
    return SitesResponseModel.fromJson(response);
  }

  Future<SitesResponseModel> searchSites({
    required SearchSitesWithPagination body,
  }) async {
    final response = await api.post(
      EndPoints.searchSitesByCode,
      data: body.searchQueryToMap(),
      queryParameters: body.pageToMap(),
    );
    return SitesResponseModel.fromJson(response);
  }

  Future<ApiResponse<SitesModel>> addSite(AddSiteBody body) async {
    final response = await api.post(
      EndPoints.addSite,
      data: body.toMap(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return ApiResponse<SitesModel>.fromJson(
      response,
      (json) => SitesModel.fromJson(json),
    );
  }

  Future<ApiResponse<SitesModel>> editSite(EditSiteBody body) async {
    final response = await api.put(
      "${EndPoints.editSite}/${body.id}",
      data: body.toMap(),
    );
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

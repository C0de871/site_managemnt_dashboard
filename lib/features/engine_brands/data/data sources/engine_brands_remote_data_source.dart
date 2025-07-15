import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/secure_storage_helper.dart';
import '../../../../core/databases/params/body.dart';
import '../../../../core/shared/data/response_model.dart';
import '../models/engine_brand_model.dart';

class EngineBrandsRemoteDataSource {
  final ApiConsumer api;
  final SecureStorageHelper cacheHelper;

  EngineBrandsRemoteDataSource({required this.api, required this.cacheHelper});

  Future<ApiResponse<List<BrandModel>>> getEngineBrands() async {
    final response = await api.get(EndPoints.getEnginesBrands);
    return ApiResponse<List<BrandModel>>.fromJson(
      response,
      (json) => (json as List).map((e) => BrandModel.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<BrandModel>> addEngineBrand(
    AddEngineBrandBody body,
  ) async {
    final response = await api.post(
      EndPoints.addEngineBrand,
      data: body.toMap(),
    );
    return ApiResponse<BrandModel>.fromJson(
      response,
      (json) => BrandModel.fromJson(json),
    );
  }

  Future<ApiResponse<BrandModel>> editEngineBrand(
    EditEngineBrandBody body,
  ) async {
    final response = await api.put(
      EndPoints.editEngineBrand,
      data: body.toMap(),
    );
    return ApiResponse<BrandModel>.fromJson(
      response,
      (json) => BrandModel.fromJson(json),
    );
  }

  Future<ApiResponse<void>> deleteEngineBrands(
    DeleteEngineBrandBody body,
  ) async {
    final response = await api.delete(
      EndPoints.deleteEngineBrand,
      data: body.toMap(),
    );
    return ApiResponse<void>.fromJson(response, (json) {});
  }
}

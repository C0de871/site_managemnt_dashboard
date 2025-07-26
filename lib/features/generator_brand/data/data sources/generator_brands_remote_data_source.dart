import 'package:site_managemnt_dashboard/features/engine_brands/data/models/engine_brand_model.dart';

import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/secure_storage_helper.dart';
import '../../../../core/databases/params/body.dart';
import '../../../../core/shared/data/response_model.dart';
import '../../../engine_brands/domain/entities/brand_entity.dart';
import '../models/generator_brand_model.dart';

class GeneratorBrandsRemoteDataSource {
  final ApiConsumer api;
  final SecureStorageHelper cacheHelper;

  GeneratorBrandsRemoteDataSource({
    required this.api,
    required this.cacheHelper,
  });

  Future<ApiResponse<List<BrandEntity>>> getGeneratorBrands() async {
    final response = await api.get(EndPoints.getGeneratorsBrands);
    return ApiResponse<List<BrandEntity>>.fromJson(
      response,
      (json) => (json as List).map((e) => BrandModel.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<BrandEntity>> addGeneratorBrand(
    AddGeneratorBrandBody body,
  ) async {
    final response = await api.post(
      EndPoints.addGeneratorBrand,
      data: body.toMap(),
    );
    return ApiResponse<BrandModel>.fromJson(
      response,
      (json) => BrandModel.fromJson(json),
    );
  }

  Future<ApiResponse<GeneratorBrandModel>> editGeneratorBrand(
    EditBrandBody body,
  ) async {
    final response = await api.put(
      '${EndPoints.editGeneratorBrand}/${body.id}',
      data: body.toMap(),
    );
    return ApiResponse<GeneratorBrandModel>.fromJson(
      response,
      (json) => GeneratorBrandModel.fromJson(json),
    );
  }

  Future<ApiResponse<void>> deleteGeneratorBrands(
    DeleteGeneratorBrandBody body,
  ) async {
    final response = await api.delete(
      EndPoints.deleteGeneratorBrand,
      data: body.toMap(),
    );
    return ApiResponse<void>.fromJson(response, (json) => json);
  }
}

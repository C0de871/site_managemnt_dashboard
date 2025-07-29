import 'package:site_managemnt_dashboard/core/databases/params/params.dart';
import 'package:site_managemnt_dashboard/features/generators/data/models/generator_response_model.dart';

import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/secure_storage_helper.dart';
import '../../../../core/databases/params/body.dart';
import '../../../../core/shared/data/response_model.dart';
import '../models/generator_model.dart';

class GeneratorsRemoteDataSource {
  final ApiConsumer api;
  final SecureStorageHelper cacheHelper;
  GeneratorsRemoteDataSource({required this.api, required this.cacheHelper});

  Future<GeneratorResponseModel> getGenerators({
    required SearchGeneratorsWithPagination params,
  }) async {
    final response = await api.get(
      EndPoints.getGenerators,
      queryParameters: params.toMap(),
    );
    return GeneratorResponseModel.fromJson(response);
  }

  Future<GeneratorResponseModel> getGeneratorsBySiteID({
    required int siteID,
  }) async {
    final response = await api.get(
      "${EndPoints.getGeneratorsBySiteID}/$siteID",
    );
    return GeneratorResponseModel.fromJson(response);
  }

  Future<ApiResponse<GeneratorModel>> addGenerator(
    CreateGeneratorBody body,
  ) async {
    final response = await api.post(
      EndPoints.createGenerator,
      data: body.toMap(),
    );
    return ApiResponse<GeneratorModel>.fromJson(
      response,
      (json) => GeneratorModel.fromJson(json),
    );
  }

  Future<ApiResponse<GeneratorModel>> editGenerator(
    EditGeneratorBody body,
  ) async {
    final response = await api.put(
      "${EndPoints.editGenerator}/${body.id}",
      data: body.toMap(),
    );
    return ApiResponse<GeneratorModel>.fromJson(
      response,
      (json) => GeneratorModel.fromJson(json),
    );
  }

  Future<ApiResponse<void>> deleteGenerators(DeleteGeneratorBody body) async {
    final response = await api.delete(
      EndPoints.deleteGenerator,
      data: body.toMap(),
    );
    return ApiResponse<void>.fromJson(response, (json) => json);
  }
}

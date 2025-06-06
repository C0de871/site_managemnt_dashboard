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

  Future<ApiResponse<List<GeneratorModel>>> getGenerators() async {
    final response = await api.get(EndPoints.getGenerators);
    return ApiResponse<List<GeneratorModel>>.fromJson(
      response,
      (json) => (json as List).map((e) => GeneratorModel.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<GeneratorModel>> addGenerator(
    CreateEngineBody body,
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
    final response = await api.put(EndPoints.editGenerator, data: body.toMap());
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

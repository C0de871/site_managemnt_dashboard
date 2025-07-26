import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/secure_storage_helper.dart';
import '../../../../core/databases/params/body.dart';
import '../../../../core/shared/data/response_model.dart';
import '../models/engine_capacity_model.dart';

class EngineCapacitiesRemoteDataSource {
  final ApiConsumer api;
  final SecureStorageHelper cacheHelper;

  EngineCapacitiesRemoteDataSource({
    required this.api,
    required this.cacheHelper,
  });

  Future<ApiResponse<List<EngineCapacityModel>>> getEngineCapacities() async {
    final response = await api.get(EndPoints.getEnginesCapacities);
    return ApiResponse<List<EngineCapacityModel>>.fromJson(
      response,
      (json) =>
          (json as List).map((e) => EngineCapacityModel.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<EngineCapacityModel>> addEngineCapacity(
    AddEngineCapacityBody body,
  ) async {
    final response = await api.post(
      EndPoints.addEngineCapacity,
      data: body.toMap(),
    );
    return ApiResponse<EngineCapacityModel>.fromJson(
      response,
      (json) => EngineCapacityModel.fromJson(json),
    );
  }

  Future<ApiResponse<EngineCapacityModel>> editEngineCapacity(
    EditEngineCapacityBody body,
  ) async {
    final response = await api.put(
      "${EndPoints.editEngineCapacity}/${body.id}",
      data: body.toMap(),
    );
    return ApiResponse<EngineCapacityModel>.fromJson(
      response,
      (json) => EngineCapacityModel.fromJson(json),
    );
  }

  Future<ApiResponse<void>> deleteEngineCapacities(
    DeleteEngineCapacityBody body,
  ) async {
    final response = await api.delete(
      EndPoints.deleteEngineCapacity,
      data: body.toMap(),
    );
    return ApiResponse<void>.fromJson(response, (json) => json);
  }
}

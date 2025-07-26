import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/params/body.dart';
import '../../../../core/shared/data/response_model.dart';
import '../models/engine_model.dart';

class EngineRemoteDataSource {
  final ApiConsumer api;

  EngineRemoteDataSource({required this.api});

  Future<ApiResponse<List<EngineModel>>> getEngines() async {
    final response = await api.get(EndPoints.getEngines);
    return ApiResponse<List<EngineModel>>.fromJson(
      response,
      (json) => (json as List).map((e) => EngineModel.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<EngineModel>> addEngine(CreateEngineBody body) async {
    final response = await api.post(EndPoints.createEngine, data: body.toMap());
    return ApiResponse<EngineModel>.fromJson(
      response,
      (json) => EngineModel.fromJson(json),
    );
  }

  Future<ApiResponse<EngineModel>> editEngine(EditEngineBody body) async {
    final response = await api.put(
      "${EndPoints.editEngine}/${body.id}",
      data: body.toMap(),
    );
    return ApiResponse<EngineModel>.fromJson(
      response,
      (json) => EngineModel.fromJson(json),
    );
  }

  Future<ApiResponse<void>> deleteEngines(DeleteEngineBody body) async {
    final response = await api.delete(
      EndPoints.deleteEngine,
      data: body.toMap(),
    );
    return ApiResponse<void>.fromJson(response, (json) => json);
  }
}

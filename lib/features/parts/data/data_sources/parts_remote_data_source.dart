import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/secure_storage_helper.dart';
import '../../../../core/databases/params/body.dart';
import '../../../../core/shared/data/response_model.dart';
import '../models/part_model.dart';

class PartsRemoteDataSource {
  final ApiConsumer api;
  final SecureStorageHelper cacheHelper;

  PartsRemoteDataSource({required this.api, required this.cacheHelper});

  Future<ApiResponse<List<PartModel>>> getParts() async {
    final response = await api.get(EndPoints.getParts);
    return ApiResponse<List<PartModel>>.fromJson(
      response,
      (json) => (json as List).map((e) => PartModel.fromJson(e)).toList(),
    );
  }

  Future<ApiResponse<PartModel>> addPart(AddPartBody body) async {
    final response = await api.post(EndPoints.addPart, data: body.toMap());
    return ApiResponse<PartModel>.fromJson(
      response,
      (json) => PartModel.fromJson(json),
    );
  }

  Future<ApiResponse<PartModel>> editPart(EditPartBody body) async {
    final response = await api.put(EndPoints.editPart, data: body.toMap());
    return ApiResponse<PartModel>.fromJson(
      response,
      (json) => PartModel.fromJson(json),
    );
  }

  Future<ApiResponse<void>> deleteParts(DeletePartBody body) async {
    final response = await api.delete(EndPoints.deletePart, data: body.toMap());
    return ApiResponse<void>.fromJson(response, (json) => json);
  }
}

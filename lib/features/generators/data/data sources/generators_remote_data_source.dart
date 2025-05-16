// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/secure_storage_helper.dart';
import '../models/generators_model.dart';

class GeneratorsRemoteDataSource {
  final ApiConsumer api;
  final SecureStorageHelper cacheHelper;
  GeneratorsRemoteDataSource({required this.api, required this.cacheHelper});
  Future<GeneratorsModel> getGenerators() async {
    final response = await api.get(EndPoints.getGenerators);
    return GeneratorsModel.fromMap(response);
  }
}

import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/shared/data/response_model.dart';
import '../models/user_model.dart';

import '../../../../core/databases/api/end_points.dart';

class UserRemoteDataSource {
  final ApiConsumer apiConsumer;

  UserRemoteDataSource(this.apiConsumer);

  Future<UserModel> login(Map<String, dynamic> body) async {
    final response = await apiConsumer.post(
      EndPoints.login,
      data: body,
      extra: {"no_auth": true},
    );
    return UserModel.fromJson(response);
  }

  Future<ApiResponse<void>> logout() async {
    final response = await apiConsumer.get(EndPoints.logout);
    return ApiResponse<void>.fromJson(response, (json) => json);
  }
}

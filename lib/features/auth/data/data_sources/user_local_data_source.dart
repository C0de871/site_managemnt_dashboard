import 'dart:convert';
import 'dart:developer';

import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/cache/cache_keys.dart';
import '../../../../core/databases/cache/storage_helper.dart';
import '../models/user_model.dart';

class UserLocalDataSource {
  final StorageHelper cacheHelper;

  UserLocalDataSource(this.cacheHelper);

  void saveAccessToken(String accessToken) {
    cacheHelper.saveData(
      key: CacheKeys.accessToken,
      value: accessToken,
    );
  }

  Future<void> deleteAccessToken() async {
    cacheHelper.removeData(key: CacheKeys.accessToken);
  }

  Future<void> deleteUser() async {
    cacheHelper.removeData(key: CacheKeys.user);
  }

  void saveUser(UserModel user) {
    String userJson = jsonEncode((user).toJson());
    cacheHelper.saveData(key: CacheKeys.user, value: userJson);
    log("user json is: $userJson");
  }

  Future<UserModel?> retrieveUser() async {
    String? userJson = await cacheHelper.getData(key: CacheKeys.user);
    log("user json is: ${userJson ?? "null"}");
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<String?> retrieveAccessToken() async {
    return await cacheHelper.getData(key: CacheKeys.accessToken);
  }
}

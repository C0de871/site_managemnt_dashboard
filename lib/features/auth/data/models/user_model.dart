import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.username,
    required super.token,
    required super.role,
  });

  static const String idKey = 'id';
  static const String usernameKey = 'username';
  static const String tokenKey = 'token';
  static const String roleKey = 'role';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[idKey] as int,
      username: json[usernameKey] as String,
      token: json[tokenKey] as String,
      role: json[roleKey] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {idKey: id, usernameKey: username, tokenKey: token, roleKey: role};
  }
}

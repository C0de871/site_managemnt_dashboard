import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.username,
    required this.token,
    required this.role,
    required this.id,
  });

  final String username;
  final String token;
  final String role;
  final int id;

  @override
  List<Object?> get props => [username, token, role, id];

  //!copy with
  UserEntity copyWith({
    String? username,
    String? token,
    String? role,
    int? id,
  }) {
    return UserEntity(
      username: username ?? this.username,
      token: token ?? this.token,
      role: role ?? this.role,
      id: id ?? this.id,
    );
  }
}

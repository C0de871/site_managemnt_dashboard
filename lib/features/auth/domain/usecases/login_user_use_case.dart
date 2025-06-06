import 'package:dartz/dartz.dart';
import '../../../../core/databases/errors/failure.dart';
import '../entities/user_entity.dart';

import '../repository/repository.dart';

class LoginUserUseCase {
  final UserRepository repository;

  LoginUserUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call({required Map<String, dynamic> body}) => repository.loginUser(body);
}

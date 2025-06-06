import 'package:dartz/dartz.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/shared/data/response_model.dart';

import '../repository/repository.dart';

class LogoutUserUseCase {
  final UserRepository repository;

  LogoutUserUseCase({required this.repository});

  Future<Either<Failure, ApiResponse<void>>> call() => repository.logout();
}

import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repository/repository.dart';

class RetreiveUserUseCase {
  final UserRepository repository;

  RetreiveUserUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call() => repository.retrieveUser();
}

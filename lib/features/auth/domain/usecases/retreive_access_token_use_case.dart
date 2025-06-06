import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../repository/repository.dart';

class RetreiveAccessTokenUseCase {
  final UserRepository repository;

  RetreiveAccessTokenUseCase({required this.repository});

  Future<Either<Failure, String>> call() => repository.retrieveAccessToken();
}

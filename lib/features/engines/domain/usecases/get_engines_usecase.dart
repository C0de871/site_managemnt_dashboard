import 'package:dartz/dartz.dart';

import '../../../../../core/databases/errors/failure.dart';
import '../entities/engine_entity.dart';
import '../repository/engine_repository.dart';

class GetEnginesUseCase {
  final EngineRepository repository;

  GetEnginesUseCase({required this.repository});

  Future<Either<Failure, List<EngineEntity>>> call() async {
    return await repository.getEngines();
  }
}

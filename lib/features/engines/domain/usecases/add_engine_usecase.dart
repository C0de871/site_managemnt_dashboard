import 'package:dartz/dartz.dart';

import '../../../../../core/databases/errors/failure.dart';
import '../../../../../core/databases/params/body.dart';
import '../entities/engine_entity.dart';
import '../repository/engine_repository.dart';

class CreateEngineUseCase {
  final EngineRepository repository;

  CreateEngineUseCase({required this.repository});

  Future<Either<Failure, EngineEntity>> call(CreateEngineBody params) async {
    return await repository.addEngine(params);
  }
}

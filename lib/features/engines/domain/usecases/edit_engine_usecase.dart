import 'package:dartz/dartz.dart';

import '../../../../../core/databases/errors/failure.dart';
import '../../../../../core/databases/params/body.dart';
import '../entities/engine_entity.dart';
import '../repository/engine_repository.dart';

class EditEngineUseCase {
  final EngineRepository repository;

  EditEngineUseCase({required this.repository});

  Future<Either<Failure, EngineEntity>> call(EditEngineBody params) async {
    return await repository.editEngine(params);
  }
}

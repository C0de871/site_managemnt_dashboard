import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/engine_entity.dart';

abstract class EngineRepository {
  Future<Either<Failure, List<EngineEntity>>> getEngines();
  Future<Either<Failure, EngineEntity>> addEngine(CreateEngineBody body);
  Future<Either<Failure, EngineEntity>> editEngine(EditEngineBody body);
  Future<Either<Failure, void>> deleteEngines(DeleteEngineBody body);
}

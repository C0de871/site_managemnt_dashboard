import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/engine_capacity_entity.dart';

abstract class EngineCapacitiesRepository {
  Future<Either<Failure, List<EngineCapacityEntity>>> getEngineCapacities();
  Future<Either<Failure, EngineCapacityEntity>> addEngineCapacity(
    AddEngineCapacityBody body,
  );
  Future<Either<Failure, EngineCapacityEntity>> editEngineCapacity(
    EditEngineCapacityBody body,
  );
  Future<Either<Failure, void>> deleteEngineCapacities(
    DeleteEngineCapacityBody body,
  );
}

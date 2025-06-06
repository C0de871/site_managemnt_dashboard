import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../../../engine_capacities/domain/entities/engine_capacity_entity.dart';
import '../../../engine_capacities/domain/repository/engine_capacities_repository.dart';

class AddEngineCapacityUsecase {
  final EngineCapacitiesRepository repository;

  AddEngineCapacityUsecase({required this.repository});

  Future<Either<Failure, EngineCapacityEntity>> call(
    AddEngineCapacityBody params,
  ) async {
    return await repository.addEngineCapacity(params);
  }
}

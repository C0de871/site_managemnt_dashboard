import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/engine_capacity_entity.dart';
import '../repository/engine_capacities_repository.dart';

class EditEngineCapacityUsecase {
  final EngineCapacitiesRepository repository;

  EditEngineCapacityUsecase({required this.repository});

  Future<Either<Failure, EngineCapacityEntity>> call(
    EditEngineCapacityBody params,
  ) async {
    return await repository.editEngineCapacity(params);
  }
}

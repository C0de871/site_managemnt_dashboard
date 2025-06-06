import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/engine_capacity_entity.dart';
import '../repository/engine_capacities_repository.dart';

class GetEngineCapacitiesUsecase {
  final EngineCapacitiesRepository repository;

  GetEngineCapacitiesUsecase({required this.repository});

  Future<Either<Failure, List<EngineCapacityEntity>>> call() async {
    return await repository.getEngineCapacities();
  }
}

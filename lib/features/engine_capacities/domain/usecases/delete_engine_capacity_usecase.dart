import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../repository/engine_capacities_repository.dart';

class DeleteEngineCapacitiesUsecase {
  final EngineCapacitiesRepository repository;

  DeleteEngineCapacitiesUsecase({required this.repository});

  Future<Either<Failure, void>> call(DeleteEngineCapacityBody params) async {
    return await repository.deleteEngineCapacities(params);
  }
}

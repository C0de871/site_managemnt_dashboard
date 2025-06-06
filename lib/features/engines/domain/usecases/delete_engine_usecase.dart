import 'package:dartz/dartz.dart';

import '../../../../../core/databases/errors/failure.dart';
import '../../../../../core/databases/params/body.dart';
import '../repository/engine_repository.dart';

class DeleteEnginesUseCase {
  final EngineRepository repository;

  DeleteEnginesUseCase({required this.repository});

  Future<Either<Failure, void>> call(DeleteEngineBody params) async {
    return await repository.deleteEngines(params);
  }
}

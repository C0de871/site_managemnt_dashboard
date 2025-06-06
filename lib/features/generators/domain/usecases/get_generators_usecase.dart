import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/generator_entity.dart';
import '../repository/generators_repository.dart';

class GetGeneratorsUseCase {
  final GeneratorsRepository repository;

  GetGeneratorsUseCase({required this.repository});

  Future<Either<Failure, List<GeneratorEntity>>> call() {
    return repository.getGenerators();
  }
}

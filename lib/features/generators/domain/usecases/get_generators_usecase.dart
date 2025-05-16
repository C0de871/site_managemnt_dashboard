import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/generator_entity.dart';
import '../repository/generators_repository.dart';

class Generators {
  final GeneratorsRepository repository;

  Generators({required this.repository});

  Future<Either<Failure, List<GeneratorEntity>>> call() {
    return repository.getGenerators();
  }
}

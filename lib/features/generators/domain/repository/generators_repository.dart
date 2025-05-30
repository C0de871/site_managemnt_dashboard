import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/generator_entity.dart';

abstract class GeneratorsRepository {
  Future<Either<Failure, List<GeneratorEntity>>> getGenerators();
}

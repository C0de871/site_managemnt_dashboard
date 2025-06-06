import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/generator_entity.dart';

abstract class GeneratorsRepository {
  Future<Either<Failure, List<GeneratorEntity>>> getGenerators();
  Future<Either<Failure, GeneratorEntity>> createGenerator(
    CreateEngineBody body,
  );
  Future<Either<Failure, GeneratorEntity>> editGenerator(
    EditGeneratorBody body,
  );
  Future<Either<Failure, void>> deleteGenerators(DeleteGeneratorBody body);
}

import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../../../../core/databases/params/params.dart';
import '../../data/models/generator_response_model.dart';
import '../entities/generator_entity.dart';

abstract class GeneratorsRepository {
  Future<Either<Failure, GeneratorResponseModel>> getGenerators({
    required SearchGeneratorsWithPagination params,
  });
  Future<Either<Failure, GeneratorResponseModel>> getGeneratorsBySiteID({
    required int siteID,
  });
  Future<Either<Failure, GeneratorEntity>> createGenerator(
    CreateGeneratorBody body,
  );
  Future<Either<Failure, GeneratorEntity>> editGenerator(
    EditGeneratorBody body,
  );
  Future<Either<Failure, void>> deleteGenerators(DeleteGeneratorBody body);
}

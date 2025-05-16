import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/generators_entity.dart';

abstract class GeneratorsRepository {
  Future<Either<Failure, GeneratorsEntity>> getGenerators();
}

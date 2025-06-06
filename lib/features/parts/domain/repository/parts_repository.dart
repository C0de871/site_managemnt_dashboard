import 'package:dartz/dartz.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/part_entity.dart';

abstract class PartsRepository {
  Future<Either<Failure, List<PartEntity>>> getParts();
  Future<Either<Failure, PartEntity>> addPart(AddPartBody body);
  Future<Either<Failure, PartEntity>> editPart(EditPartBody body);
  Future<Either<Failure, void>> deleteParts(DeletePartBody body);
}

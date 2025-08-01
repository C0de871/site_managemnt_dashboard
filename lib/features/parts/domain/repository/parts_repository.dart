import 'package:dartz/dartz.dart';
import 'package:site_managemnt_dashboard/core/databases/params/params.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/part_entity.dart';
import '../entities/part_response_entity.dart';

abstract class PartsRepository {
  Future<Either<Failure, PartResponseEntity>> getParts({required SearchPartsWithPagination params});
  Future<Either<Failure, PartEntity>> addPart(AddPartBody body);
  Future<Either<Failure, PartEntity>> editPart(EditPartBody body);
  Future<Either<Failure, void>> deleteParts(DeletePartBody body);
}

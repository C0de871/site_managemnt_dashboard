import 'package:dartz/dartz.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/brand_entity.dart';

abstract class EngineBrandsRepository {
  Future<Either<Failure, List<BrandEntity>>> getEngineBrands();
  Future<Either<Failure, BrandEntity>> addEngineBrand(AddEngineBrandBody body);
  Future<Either<Failure, BrandEntity>> editEngineBrand(
    EditEngineBrandBody body,
  );
  Future<Either<Failure, void>> deleteEngineBrands(DeleteEngineBrandBody body);
}

import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/generator_brand_entity.dart';

abstract class GeneratorBrandsRepository {
  Future<Either<Failure, List<GeneratorBrandEntity>>> getGeneratorBrands();
  Future<Either<Failure, void>> deleteGeneratorBrands(
    DeleteGeneratorBrandBody body,
  );
  Future<Either<Failure, GeneratorBrandEntity>> addGeneratorBrand(
    AddGeneratorBrandBody body,
  );
  Future<Either<Failure, GeneratorBrandEntity>> editGeneratorBrand(
    EditGeneratorBrandBody body,
  );
}

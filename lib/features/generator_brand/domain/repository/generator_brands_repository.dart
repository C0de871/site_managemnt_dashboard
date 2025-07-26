import 'package:dartz/dartz.dart';
import 'package:site_managemnt_dashboard/features/engine_brands/domain/entities/brand_entity.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/generator_brand_entity.dart';

abstract class GeneratorBrandsRepository {
  Future<Either<Failure, List<BrandEntity>>> getGeneratorBrands();
  Future<Either<Failure, void>> deleteGeneratorBrands(
    DeleteGeneratorBrandBody body,
  );
  Future<Either<Failure, BrandEntity>> addGeneratorBrand(
    AddGeneratorBrandBody body,
  );
  Future<Either<Failure, GeneratorBrandEntity>> editGeneratorBrand(
    EditBrandBody body,
  );
}

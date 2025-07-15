import 'package:dartz/dartz.dart';
import 'package:site_managemnt_dashboard/features/engine_brands/domain/entities/brand_entity.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/generator_brand_entity.dart';
import '../repository/generator_brands_repository.dart';

class AddGeneratorBrandUsecase {
  final GeneratorBrandsRepository repository;

  AddGeneratorBrandUsecase({required this.repository});

  Future<Either<Failure, BrandEntity>> call(
    AddGeneratorBrandBody params,
  ) async {
    return await repository.addGeneratorBrand(params);
  }
}

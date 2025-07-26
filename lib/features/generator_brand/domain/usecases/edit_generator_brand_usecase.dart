import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/generator_brand_entity.dart';
import '../repository/generator_brands_repository.dart';

class EditGeneratorBrandUsecase {
  final GeneratorBrandsRepository repository;

  EditGeneratorBrandUsecase({required this.repository});

  Future<Either<Failure, GeneratorBrandEntity>> call(
    EditBrandBody params,
  ) async {
    return await repository.editGeneratorBrand(params);
  }
}

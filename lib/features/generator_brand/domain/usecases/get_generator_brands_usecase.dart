import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/generator_brand_entity.dart';
import '../repository/generator_brands_repository.dart';

class GetGeneratorBrandsUsecase {
  final GeneratorBrandsRepository repository;

  GetGeneratorBrandsUsecase({required this.repository});

  Future<Either<Failure, List<GeneratorBrandEntity>>> call() async {
    return await repository.getGeneratorBrands();
  }
}

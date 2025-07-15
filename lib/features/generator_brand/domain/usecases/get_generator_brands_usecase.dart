import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../engine_brands/domain/entities/brand_entity.dart';
import '../repository/generator_brands_repository.dart';

class GetGeneratorBrandsUsecase {
  final GeneratorBrandsRepository repository;

  GetGeneratorBrandsUsecase({required this.repository});

  Future<Either<Failure, List<BrandEntity>>> call() async {
    return await repository.getGeneratorBrands();
  }
}

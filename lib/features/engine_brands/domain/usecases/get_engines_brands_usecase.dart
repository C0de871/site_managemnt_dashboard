import 'package:dartz/dartz.dart';

import '../../../../../core/databases/errors/failure.dart';
import '../entities/brand_entity.dart';
import '../repository/engine_brands_repository.dart';

class GetEngineBrandsUsecase {
  final EngineBrandsRepository repository;

  GetEngineBrandsUsecase({required this.repository});

  Future<Either<Failure, List<BrandEntity>>> call() {
    return repository.getEngineBrands();
  }
}

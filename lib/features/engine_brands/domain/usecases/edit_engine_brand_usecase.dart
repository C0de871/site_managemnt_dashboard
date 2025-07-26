import 'package:dartz/dartz.dart';

import '../../../../../core/databases/errors/failure.dart';
import '../../../../../core/databases/params/body.dart';
import '../entities/brand_entity.dart';
import '../repository/engine_brands_repository.dart';

class EditEngineBrandUsecase {
  final EngineBrandsRepository repository;

  EditEngineBrandUsecase({required this.repository});

  Future<Either<Failure, BrandEntity>> call(EditBrandBody body) {
    return repository.editEngineBrand(body);
  }
}

import 'package:dartz/dartz.dart';

import '../../../../../core/databases/errors/failure.dart';
import '../../../../../core/databases/params/body.dart';
import '../repository/engine_brands_repository.dart';

class DeleteEngineBrandsUsecase {
  final EngineBrandsRepository repository;

  DeleteEngineBrandsUsecase({required this.repository});

  Future<Either<Failure, void>> call(DeleteEngineBrandBody body) {
    return repository.deleteEngineBrands(body);
  }
}

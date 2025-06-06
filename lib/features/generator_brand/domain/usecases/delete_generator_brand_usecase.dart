import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../repository/generator_brands_repository.dart';

class DeleteGeneratorBrandsUsecase {
  final GeneratorBrandsRepository repository;

  DeleteGeneratorBrandsUsecase({required this.repository});

  Future<Either<Failure, void>> call(DeleteGeneratorBrandBody params) async {
    return await repository.deleteGeneratorBrands(params);
  }
}

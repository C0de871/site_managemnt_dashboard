import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../repository/generators_repository.dart';

class DeleteGeneratorsUsecase {
  final GeneratorsRepository generator;

  DeleteGeneratorsUsecase({required this.generator});

  Future<Either<Failure, void>> call(DeleteGeneratorBody body) async {
    return generator.deleteGenerators(body);
  }
}

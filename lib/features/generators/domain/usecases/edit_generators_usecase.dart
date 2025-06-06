import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/generator_entity.dart';
import '../repository/generators_repository.dart';

class EditGeneratorUsecase {
  final GeneratorsRepository repository;

  EditGeneratorUsecase({required this.repository});

  Future<Either<Failure, GeneratorEntity>> call(EditGeneratorBody body) async {
    return repository.editGenerator(body);
  }
}

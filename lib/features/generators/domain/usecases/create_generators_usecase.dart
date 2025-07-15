import 'package:dartz/dartz.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/repository/generators_repository.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/generator_entity.dart';

class CreateGeneratorUsecase {
  final GeneratorsRepository repository;

  CreateGeneratorUsecase({required this.repository});

  Future<Either<Failure, GeneratorEntity>> call(CreateGeneratorBody body) async {
    return repository.createGenerator(body);
  }
}

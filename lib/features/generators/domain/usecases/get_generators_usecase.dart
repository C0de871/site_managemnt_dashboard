import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/params.dart';
import '../../data/models/generator_response_model.dart';
import '../entities/generator_entity.dart';
import '../repository/generators_repository.dart';

class GetGeneratorsUseCase {
  final GeneratorsRepository repository;

  GetGeneratorsUseCase({required this.repository});

  Future<Either<Failure, GeneratorResponseModel>> call({
    required SearchGeneratorsWithPagination params,
  }) {
    return repository.getGenerators(params: params);
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../data/models/generator_response_model.dart';
import '../repository/generators_repository.dart';

class GetGeneratorsBySiteIDUsecase {
  final GeneratorsRepository repository;

  GetGeneratorsBySiteIDUsecase({required this.repository});

  Future<Either<Failure, GeneratorResponseModel>> call({required int siteID}) {
    return repository.getGeneratorsBySiteID(siteID: siteID);
  }
}

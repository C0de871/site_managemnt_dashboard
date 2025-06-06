import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/part_entity.dart';
import '../repository/parts_repository.dart';

class GetPartsUsecase {
  final PartsRepository repository;

  GetPartsUsecase({required this.repository});

  Future<Either<Failure, List<PartEntity>>> call() async {
    return await repository.getParts();
  }
}

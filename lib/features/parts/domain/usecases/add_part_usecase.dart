import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/part_entity.dart';
import '../repository/parts_repository.dart';

class AddPartUsecase {
  final PartsRepository repository;

  AddPartUsecase({required this.repository});

  Future<Either<Failure, PartEntity>> call(AddPartBody params) async {
    return await repository.addPart(params);
  }
}

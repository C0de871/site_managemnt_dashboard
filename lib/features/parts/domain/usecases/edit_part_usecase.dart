import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/part_entity.dart';
import '../repository/parts_repository.dart';

class EditPartUsecase {
  final PartsRepository repository;

  EditPartUsecase({required this.repository});

  Future<Either<Failure, PartEntity>> call(EditPartBody params) async {
    return await repository.editPart(params);
  }
}

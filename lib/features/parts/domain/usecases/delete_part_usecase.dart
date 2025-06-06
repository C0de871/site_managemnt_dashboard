import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../repository/parts_repository.dart';

class DeletePartsUsecase {
  final PartsRepository repository;

  DeletePartsUsecase({required this.repository});

  Future<Either<Failure, void>> call(DeletePartBody params) async {
    return await repository.deleteParts(params);
  }
}

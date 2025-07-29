import 'package:dartz/dartz.dart';
import 'package:site_managemnt_dashboard/features/parts/domain/entities/part_response_entity.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/params.dart';
import '../repository/parts_repository.dart';

class GetPartsUsecase {
  final PartsRepository repository;

  GetPartsUsecase({required this.repository});

  Future<Either<Failure, PartResponseEntity>> call({required SearchPartsWithPagination params}) async {
    return await repository.getParts(params:params);
  }
}

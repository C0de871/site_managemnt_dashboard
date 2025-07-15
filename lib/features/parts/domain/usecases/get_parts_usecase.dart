import 'package:dartz/dartz.dart';
import 'package:site_managemnt_dashboard/features/parts/domain/entities/part_response_entity.dart';

import '../../../../core/databases/errors/failure.dart';
import '../repository/parts_repository.dart';

class GetPartsUsecase {
  final PartsRepository repository;

  GetPartsUsecase({required this.repository});

  Future<Either<Failure, PartResponseEntity>> call({required int page}) async {
    return await repository.getParts(page:page);
  }
}

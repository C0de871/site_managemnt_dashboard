import 'package:dartz/dartz.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/entities/sites_response_entity.dart';

import '../../../../core/databases/errors/failure.dart';
import '../repository/sites_repository.dart';

class GetAllSitesUseCase {
  final SitesRepository repository;

  GetAllSitesUseCase({required this.repository});

  Future<Either<Failure, SitesResponseEntity>> call({required int page}) {
    return repository.getSites(page: page);
  }
}

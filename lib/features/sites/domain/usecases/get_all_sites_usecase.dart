import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/sites_entity.dart';
import '../repository/sites_repository.dart';

class GetAllSitesUseCase {
  final SitesRepository repository;

  GetAllSitesUseCase({required this.repository});

  Future<Either<Failure, List<SiteEntity>>> call() {
    return repository.getSites();
  }
}

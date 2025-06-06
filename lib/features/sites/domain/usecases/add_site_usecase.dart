import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/sites_entity.dart';
import '../repository/sites_repository.dart';
import '../../../../core/databases/params/body.dart';

class AddSiteUseCase {
  final SitesRepository repository;
  AddSiteUseCase({required this.repository});
  Future<Either<Failure, SiteEntity>> call(AddSiteBody body) {
    return repository.addSite(body);
  }
}

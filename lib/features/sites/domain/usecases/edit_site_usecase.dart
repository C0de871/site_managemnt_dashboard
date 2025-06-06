import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/sites_entity.dart';
import '../repository/sites_repository.dart';
import '../../../../core/databases/params/body.dart';

class EditSiteUseCase {
  final SitesRepository repository;
  EditSiteUseCase({required this.repository});
  Future<Either<Failure, SiteEntity>> call(EditSiteBody body) {
    return repository.editSite(body);
  }
}

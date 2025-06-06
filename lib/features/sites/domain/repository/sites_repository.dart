import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/sites_entity.dart';

abstract class SitesRepository {
  Future<Either<Failure, List<SiteEntity>>> getSites();
  Future<Either<Failure, SiteEntity>> addSite(AddSiteBody body);
  Future<Either<Failure, SiteEntity>> editSite(EditSiteBody body);
  Future<Either<Failure, void>> deleteSite(DeleteSiteBody body);
}

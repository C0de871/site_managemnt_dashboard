import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/sites_entity.dart';
import '../entities/sites_response_entity.dart';

abstract class SitesRepository {
  Future<Either<Failure, SitesResponseEntity>> getSites({required int page});
  Future<Either<Failure, SitesResponseEntity>> searchSites({
    required SearchSitesWithPagination body,
  });
  
  Future<Either<Failure, SiteEntity>> addSite(AddSiteBody body);
  Future<Either<Failure, SiteEntity>> editSite(EditSiteBody body);
  Future<Either<Failure, void>> deleteSite(DeleteSiteBody body);
}

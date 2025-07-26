import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/sites_response_entity.dart';
import '../repository/sites_repository.dart';

class SearchSitesUseCase {
  final SitesRepository repository;

  SearchSitesUseCase({required this.repository});

  Future<Either<Failure, SitesResponseEntity>> call({
    required SearchSitesWithPagination body,
  }) async {
    return repository.searchSites(body: body);
  }
}

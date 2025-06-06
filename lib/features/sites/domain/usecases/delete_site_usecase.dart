import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../repository/sites_repository.dart';
import '../../../../core/databases/params/body.dart';

class DeleteSiteUseCase {
  final SitesRepository repository;
  DeleteSiteUseCase({required this.repository});
  Future<Either<Failure, void>> call(DeleteSiteBody body) {
    return repository.deleteSite(body);
  }
}

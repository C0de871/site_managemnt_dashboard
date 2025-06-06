import 'package:dartz/dartz.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../../domain/entities/sites_entity.dart';
import '../../domain/repository/sites_repository.dart';
import '../data_sources/sites_remote_data_source.dart';

class SitesRepositoryImpl extends SitesRepository {
  final NetworkInfo networkInfo;
  final SitesRemoteDataSource remoteDataSource;
  SitesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<SiteEntity>>> getSites() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.getSites();
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, SiteEntity>> addSite(AddSiteBody body) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.addSite(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, SiteEntity>> editSite(EditSiteBody body) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.editSite(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSite(DeleteSiteBody body) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.deleteSite(body);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }
}

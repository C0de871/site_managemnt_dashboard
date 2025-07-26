import 'package:dartz/dartz.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../../domain/entities/brand_entity.dart';
import '../../domain/repository/engine_brands_repository.dart';
import '../data sources/engine_brands_remote_data_source.dart';

class EngineBrandsRepositoryImpl extends EngineBrandsRepository {
  final NetworkInfo networkInfo;
  final EngineBrandsRemoteDataSource remoteDataSource;

  EngineBrandsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<BrandEntity>>> getEngineBrands() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.getEngineBrands();
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, BrandEntity>> addEngineBrand(
    AddEngineBrandBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.addEngineBrand(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, BrandEntity>> editEngineBrand(
    EditBrandBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.editEngineBrand(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEngineBrands(
    DeleteEngineBrandBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.deleteEngineBrands(body);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }
}

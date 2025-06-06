import 'package:dartz/dartz.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../../domain/entities/generator_brand_entity.dart';
import '../../domain/repository/generator_brands_repository.dart';
import '../data sources/generator_brands_remote_data_source.dart';

class GeneratorBrandsRepositoryImpl extends GeneratorBrandsRepository {
  final NetworkInfo networkInfo;
  final GeneratorBrandsRemoteDataSource remoteDataSource;

  GeneratorBrandsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<GeneratorBrandEntity>>>
  getGeneratorBrands() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.getGeneratorBrands();
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, GeneratorBrandEntity>> addGeneratorBrand(
    AddGeneratorBrandBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.addGeneratorBrand(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, GeneratorBrandEntity>> editGeneratorBrand(
    EditGeneratorBrandBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.editGeneratorBrand(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGeneratorBrands(
    DeleteGeneratorBrandBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.deleteGeneratorBrands(body);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }
}

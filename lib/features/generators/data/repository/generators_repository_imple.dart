import 'package:dartz/dartz.dart';
import 'package:site_managemnt_dashboard/core/databases/params/params.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../../domain/entities/generator_entity.dart';
import '../../domain/repository/generators_repository.dart';
import '../data sources/generators_remote_data_source.dart';
import '../models/generator_response_model.dart';

class GeneratorsRepositoryImple extends GeneratorsRepository {
  final NetworkInfo networkInfo;
  final GeneratorsRemoteDataSource remoteDataSource;
  GeneratorsRepositoryImple({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, GeneratorResponseModel>> getGenerators({
    required SearchGeneratorsWithPagination params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteTempleT = await remoteDataSource.getGenerators(
          params: params,
        );

        return Right(remoteTempleT);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, GeneratorResponseModel>> getGeneratorsBySiteID({
    required int siteID,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteResponse = await remoteDataSource.getGeneratorsBySiteID(
          siteID: siteID,
        );
        return Right(remoteResponse);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, GeneratorEntity>> createGenerator(
    CreateGeneratorBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.addGenerator(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, GeneratorEntity>> editGenerator(
    EditGeneratorBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.editGenerator(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGenerators(
    DeleteGeneratorBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.deleteGenerators(body);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }
}

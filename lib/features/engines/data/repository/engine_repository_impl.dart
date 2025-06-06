import 'package:dartz/dartz.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../../domain/entities/engine_entity.dart';
import '../data sources/engine_remote_data_source.dart';
import '../../domain/repository/engine_repository.dart';

class EngineRepositoryImpl extends EngineRepository {
  final EngineRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EngineRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<EngineEntity>>> getEngines() async {
    if (await networkInfo.isConnected!) {
      try {
        final response = await remoteDataSource.getEngines();
        return Right(response.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, EngineEntity>> addEngine(CreateEngineBody body) async {
    if (await networkInfo.isConnected!) {
      try {
        final response = await remoteDataSource.addEngine(body);
        return Right(response.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, EngineEntity>> editEngine(EditEngineBody body) async {
    if (await networkInfo.isConnected!) {
      try {
        final response = await remoteDataSource.editEngine(body);
        return Right(response.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEngines(DeleteEngineBody body) async {
    if (await networkInfo.isConnected!) {
      try {
        final response = await remoteDataSource.deleteEngines(body);
        return Right(response.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }
}

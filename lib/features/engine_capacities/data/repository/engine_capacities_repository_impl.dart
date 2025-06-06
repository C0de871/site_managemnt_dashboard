import 'package:dartz/dartz.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../../domain/entities/engine_capacity_entity.dart';
import '../../domain/repository/engine_capacities_repository.dart';
import '../data sources/engine_capacities_remote_data_source.dart';

class EngineCapacitiesRepositoryImpl extends EngineCapacitiesRepository {
  final NetworkInfo networkInfo;
  final EngineCapacitiesRemoteDataSource remoteDataSource;

  EngineCapacitiesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<EngineCapacityEntity>>>
  getEngineCapacities() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.getEngineCapacities();
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, EngineCapacityEntity>> addEngineCapacity(
    AddEngineCapacityBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.addEngineCapacity(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, EngineCapacityEntity>> editEngineCapacity(
    EditEngineCapacityBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.editEngineCapacity(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEngineCapacities(
    DeleteEngineCapacityBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.deleteEngineCapacities(body);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }
}

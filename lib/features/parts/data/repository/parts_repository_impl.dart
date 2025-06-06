import 'package:dartz/dartz.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../../domain/entities/part_entity.dart';
import '../../domain/repository/parts_repository.dart';
import '../data_sources/parts_remote_data_source.dart';

class PartsRepositoryImpl extends PartsRepository {
  final NetworkInfo networkInfo;
  final PartsRemoteDataSource remoteDataSource;

  PartsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PartEntity>>> getParts() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.getParts();
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, PartEntity>> addPart(AddPartBody body) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.addPart(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, PartEntity>> editPart(EditPartBody body) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.editPart(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteParts(DeletePartBody body) async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.deleteParts(body);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connection"));
    }
  }
}

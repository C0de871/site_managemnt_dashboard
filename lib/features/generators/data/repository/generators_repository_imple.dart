import 'package:dartz/dartz.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../domain/entities/generators_entity.dart';
import '../../domain/repository/generators_repository.dart';
import '../data sources/generators_remote_data_source.dart';

class GeneratorsRepositoryImple extends GeneratorsRepository {
  final NetworkInfo networkInfo;
  final GeneratorsRemoteDataSource remoteDataSource;
  GeneratorsRepositoryImple({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, GeneratorsEntity>> getGenerators() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteTempleT = await remoteDataSource.getGenerators();

        return Right(remoteTempleT);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      //TODO make this message adapt to app language:
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }
}

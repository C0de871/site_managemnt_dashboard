import 'package:dartz/dartz.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../domain/entities/report_entity.dart';
import '../../domain/repository/reports_repository.dart';
import '../data_sources/reports_remote_data_source.dart';

class ReportsRepositoryImpl extends ReportsRepository {
  final NetworkInfo networkInfo;
  final ReportsRemoteDataSource remoteDataSource;
  ReportsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ReportEntity>>> getReports() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.getReports();
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }
}

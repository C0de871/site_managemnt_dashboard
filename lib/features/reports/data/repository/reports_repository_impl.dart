import 'package:dartz/dartz.dart';
import 'package:site_managemnt_dashboard/core/databases/params/body.dart';
import 'package:site_managemnt_dashboard/features/reports/domain/entities/report_response_entity.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
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
  Future<Either<Failure, ReportResponseEntity>> getReports({required int page}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.getReports(page:page);
        return Right(remoteData);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  @override
  Future<Either<Failure, void>> exportReports({
    required ExportReportsBody body,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.exportReports(body: body);
        return Right(remoteData);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }
}

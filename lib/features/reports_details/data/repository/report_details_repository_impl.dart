import 'package:dartz/dartz.dart';

import '../../../../core/databases/connection/network_info.dart';
import '../../../../core/databases/errors/expentions.dart';
import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../../domain/entities/report_details_entity.dart';
import '../../domain/repository/report_details_repository.dart';
import '../data_sources/report_details_remote_data_source.dart';

class ReportDetailsRepositoryImpl extends ReportDetailsRepository {
  final NetworkInfo networkInfo;
  final ReportDetailsRemoteDataSource remoteDataSource;
  ReportDetailsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ReportDetailsEntity>> getReportDetailsById(
    GetReportByIDBody body,
  ) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteData = await remoteDataSource.getReportDetailsById(body);
        return Right(remoteData.data);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "There is no internet connnect"));
    }
  }

  // @override
  // Future<Either<Failure, ReportDetailsEntity>> addReport(
  //   AddReportBody body,
  // ) async {
  //   if (await networkInfo.isConnected!) {
  //     try {
  //       final remoteData = await remoteDataSource.addReport(body);
  //       return Right(remoteData.data);
  //     } on ServerException catch (e) {
  //       return Left(Failure(errMessage: e.errorModel.errorMessage));
  //     }
  //   } else {
  //     return Left(Failure(errMessage: "There is no internet connnect"));
  //   }
  // }

  // @override
  // Future<Either<Failure, ReportDetailsEntity>> editReport(
  //   EditReportBody body,
  // ) async {
  //   if (await networkInfo.isConnected!) {
  //     try {
  //       final remoteData = await remoteDataSource.editReport(body);
  //       return Right(remoteData.data);
  //     } on ServerException catch (e) {
  //       return Left(Failure(errMessage: e.errorModel.errorMessage));
  //     }
  //   } else {
  //     return Left(Failure(errMessage: "There is no internet connnect"));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> deleteReport(DeleteReportBody body) async {
  //   if (await networkInfo.isConnected!) {
  //     try {
  //       await remoteDataSource.deleteReport(body);
  //       return const Right(null);
  //     } on ServerException catch (e) {
  //       return Left(Failure(errMessage: e.errorModel.errorMessage));
  //     }
  //   } else {
  //     return Left(Failure(errMessage: "There is no internet connnect"));
  //   }
  // }
}

import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../entities/report_details_entity.dart';

abstract class ReportDetailsRepository {
  Future<Either<Failure, ReportDetailsEntity>> getReportDetailsById(
    GetReportByIDBody body,
  );
  // Future<Either<Failure, ReportDetailsEntity>> addReport(AddReportBody body);
  // Future<Either<Failure, ReportDetailsEntity>> editReport(EditReportBody body);
  // Future<Either<Failure, void>> deleteReport(DeleteReportBody body);
}

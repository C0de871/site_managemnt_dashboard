import 'package:dartz/dartz.dart';
import 'package:site_managemnt_dashboard/features/reports/domain/entities/report_response_entity.dart';

import '../../../../core/databases/errors/failure.dart';

abstract class ReportsRepository {
  Future<Either<Failure, ReportResponseEntity>> getReports();
}

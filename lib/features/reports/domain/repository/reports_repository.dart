import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/report_entity.dart';

abstract class ReportsRepository {
  Future<Either<Failure, List<ReportEntity>>> getReports();
}

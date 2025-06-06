import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/report_entity.dart';
import '../repository/reports_repository.dart';

class GetReportsUsecase {
  final ReportsRepository repository;

  GetReportsUsecase({required this.repository});

  Future<Either<Failure, List<ReportEntity>>> call() {
    return repository.getReports();
  }
}

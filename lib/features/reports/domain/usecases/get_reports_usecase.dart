import 'package:dartz/dartz.dart';
import 'package:site_managemnt_dashboard/features/reports/domain/entities/report_response_entity.dart';

import '../../../../core/databases/errors/failure.dart';
import '../repository/reports_repository.dart';

class GetReportsUsecase {
  final ReportsRepository repository;

  GetReportsUsecase({required this.repository});

  Future<Either<Failure, ReportResponseEntity>> call({required int page}) {
    return repository.getReports(page: page);
  }
}

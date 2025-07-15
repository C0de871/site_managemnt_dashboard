import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../../../../core/databases/params/body.dart';
import '../repository/reports_repository.dart';

class ExportReportsUsecase {
  final ReportsRepository repository;

  ExportReportsUsecase({required this.repository});

  Future<Either<Failure, void>> call({required ExportReportsBody body}) {
    return repository.exportReports(body: body);
  }
}

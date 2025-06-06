import 'package:dartz/dartz.dart';

import '../../../../core/databases/errors/failure.dart';
import '../entities/report_details_entity.dart';
import '../repository/report_details_repository.dart';
import '../../../../core/databases/params/body.dart';

class GetReportDetailsUsecase {
  final ReportDetailsRepository repository;

  GetReportDetailsUsecase({required this.repository});

  Future<Either<Failure, ReportDetailsEntity>> call(GetReportByIDBody body) {
    return repository.getReportDetailsById(body);
  }
}

// class AddReportUseCase {
//   final ReportDetailsRepository repository;
//   AddReportUseCase({required this.repository});
//   Future<Either<Failure, ReportDetailsEntity>> call(AddReportBody body) {
//     return repository.addReport(body);
//   }
// }

// class EditReportUseCase {
//   final ReportDetailsRepository repository;
//   EditReportUseCase({required this.repository});
//   Future<Either<Failure, ReportDetailsEntity>> call(EditReportBody body) {
//     return repository.editReport(body);
//   }
// }

// class DeleteReportUseCase {
//   final ReportDetailsRepository repository;
//   DeleteReportUseCase({required this.repository});
//   Future<Either<Failure, void>> call(DeleteReportBody body) {
//     return repository.deleteReport(body);
//   }
// }

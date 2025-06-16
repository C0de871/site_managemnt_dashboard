import 'package:equatable/equatable.dart';
import 'package:site_managemnt_dashboard/core/shared/domain/entities/pagination_entity.dart';

import 'report_entity.dart';

class ReportResponseEntity extends Equatable {
  final List<ReportEntity> reports;
  final PaginationEntity pagination;
  const ReportResponseEntity({required this.reports, required this.pagination});
  @override
  List<Object?> get props => [reports, pagination];

  //copy with:
  ReportResponseEntity copyWith({
    List<ReportEntity>? reports,
    PaginationEntity? pagination,
  }) {
    return ReportResponseEntity(
      reports: reports ?? this.reports,
      pagination: pagination ?? this.pagination,
    );
  }
}

part of 'reports_cubit.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {
  final List<ReportEntity> reports;
  final PaginationEntity pagination;
  final List<ReportEntity> filteredReports;
  final Set<String> selectedReportIds;

  const ReportsLoaded({
    required this.reports,
    required this.filteredReports,
    required this.selectedReportIds,
    required this.pagination,
  });

  @override
  List<Object> get props => [
    reports,
    filteredReports,
    selectedReportIds,
    pagination,
  ];

  ReportsLoaded copyWith({
    List<ReportEntity>? reports,
    List<ReportEntity>? filteredReports,
    Set<String>? selectedReportIds,
    PaginationEntity? pagination,
  }) {
    return ReportsLoaded(
      reports: reports ?? this.reports,
      filteredReports: filteredReports ?? this.filteredReports,
      selectedReportIds: selectedReportIds ?? this.selectedReportIds,
      pagination: pagination ?? this.pagination,
    );
  }
}

class ReportsActionInProgress extends ReportsState {
  final ReportsLoaded baseState;
  final String action;

  const ReportsActionInProgress({
    required this.baseState,
    required this.action,
  });

  @override
  List<Object> get props => [baseState, action];
}

class ReportsActionSuccess extends ReportsLoaded {
  const ReportsActionSuccess({
    required super.reports,
    required super.filteredReports,
    required super.selectedReportIds,
    required super.pagination,
  });
}

class ReportsError extends ReportsState {
  final String message;

  const ReportsError(this.message);

  @override
  List<Object> get props => [message];
}

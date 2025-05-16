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
  final List<ReportEntity> filteredReports;
  final Set<String> selectedReportIds;

  const ReportsLoaded({
    required this.reports,
    required this.filteredReports,
    required this.selectedReportIds,
  });

  @override
  List<Object> get props => [reports, filteredReports, selectedReportIds];

  ReportsLoaded copyWith({
    List<ReportEntity>? reports,
    List<ReportEntity>? filteredReports,
    Set<String>? selectedReportIds,
  }) {
    return ReportsLoaded(
      reports: reports ?? this.reports,
      filteredReports: filteredReports ?? this.filteredReports,
      selectedReportIds: selectedReportIds ?? this.selectedReportIds,
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

class ReportsError extends ReportsState {
  final String message;

  const ReportsError(this.message);

  @override
  List<Object> get props => [message];
}
part of 'report_details_cubit.dart';

class ReportDetailsState extends Equatable {
  const ReportDetailsState({
    this.reportDetails,
    this.reportDetailsStatus = ReportDetailsStatus.initial,
    this.loadReportErrorMsg = "",
  });

  final ReportDetailsEntity? reportDetails;
  final ReportDetailsStatus reportDetailsStatus;

  final String loadReportErrorMsg;

  @override
  List<Object?> get props => [
    reportDetails,
    reportDetailsStatus,
    loadReportErrorMsg,
  ];

  ReportDetailsState copyWith({
    ReportDetailsEntity? reportDetails,
    ReportDetailsStatus? reportDetailsStatus,
    String? loadReportErrorMsg,
  }) {
    return ReportDetailsState(
      reportDetails: reportDetails ?? this.reportDetails,
      reportDetailsStatus: reportDetailsStatus ?? this.reportDetailsStatus,
      loadReportErrorMsg: loadReportErrorMsg ?? this.loadReportErrorMsg,
    );
  }
}

enum ReportDetailsStatus { initial, loading, loaded, error }

extension ReportDetailsStatusX on ReportDetailsStatus {
  bool get isInitial => this == ReportDetailsStatus.initial;
  bool get isLoading => this == ReportDetailsStatus.loading;
  bool get isLoaded => this == ReportDetailsStatus.loaded;
  bool get isError => this == ReportDetailsStatus.error;
}

part of 'reports_cubit.dart';

class ReportsState extends Equatable {
  //!Load reports fields:
  final List<ReportEntity> reports;
  final PaginationEntity? pagination;
  final List<ReportEntity> filteredReports;
  final Set<String> selectedReportIds;
  final String fetchReportErrorMessage;
  final ReportsStatus reportsStatus;

  //!Delete reports fields:
  final DeleteReportsStatus deleteReportsStatus;
  final String deleteReportErrorMessage;

  //!Edit Reports fields:
  final EditReportStatus editReportStatus;
  final String editReportErrorMessage;

  //!Export Reports fields:
  final ExportReportsStatus exportReportsStatus;
  final String exportReportErrorMessage;

  const ReportsState({
    //!Load reports fields:
    this.reports = const [],
    this.filteredReports = const [],
    this.selectedReportIds = const {},
    this.pagination,
    this.fetchReportErrorMessage = '',
    this.reportsStatus = ReportsStatus.initial,

    //!Delete reports fields:
    this.deleteReportsStatus = DeleteReportsStatus.initial,
    this.deleteReportErrorMessage = '',

    //!Edit Reports fields:
    this.editReportStatus = EditReportStatus.initial,
    this.editReportErrorMessage = '',

    //!Export Reports fields:
    this.exportReportsStatus = ExportReportsStatus.initial,
    this.exportReportErrorMessage = '',
  });

  @override
  List<Object?> get props => [
    //!Load reports fields:
    reports,
    filteredReports,
    selectedReportIds,
    pagination,
    fetchReportErrorMessage,
    reportsStatus,

    //!Delete reports fields:
    deleteReportsStatus,
    deleteReportErrorMessage,

    //!Edit Reports fields:
    editReportStatus,
    editReportErrorMessage,

    //!Export Reports fields:
    exportReportsStatus,
    exportReportErrorMessage,
  ];

  ReportsState copyWith({
    //!Load reports fields:
    List<ReportEntity>? reports,
    List<ReportEntity>? filteredReports,
    Set<String>? selectedReportIds,
    PaginationEntity? pagination,
    String? fetchReportErrorMessage,
    ReportsStatus? reportsStatus,

    //!Delete reports fields:
    DeleteReportsStatus? deleteReportsStatus,
    String? deleteReportErrorMessage,

    //!Edit Reports fields:
    EditReportStatus? editReportStatus,
    String? editReportErrorMessage,

    //!Export Reports fields:
    ExportReportsStatus? exportReportsStatus,
    String? exportReportErrorMessage,
  }) {
    return ReportsState(
      //!Load reports fields:
      reports: reports ?? this.reports,
      filteredReports: filteredReports ?? this.filteredReports,
      selectedReportIds: selectedReportIds ?? this.selectedReportIds,
      pagination: pagination ?? this.pagination,
      fetchReportErrorMessage:
          fetchReportErrorMessage ?? this.fetchReportErrorMessage,
      reportsStatus: reportsStatus ?? this.reportsStatus,

      //!Delete reports fields:
      deleteReportsStatus: deleteReportsStatus ?? this.deleteReportsStatus,
      deleteReportErrorMessage:
          deleteReportErrorMessage ?? this.deleteReportErrorMessage,

      //!Edit Reports fields:
      editReportStatus: editReportStatus ?? this.editReportStatus,
      editReportErrorMessage:
          editReportErrorMessage ?? this.editReportErrorMessage,

      //!Export Reports fields:
      exportReportsStatus: exportReportsStatus ?? this.exportReportsStatus,
      exportReportErrorMessage:
          exportReportErrorMessage ?? this.exportReportErrorMessage,
    );
  }
}

enum ExportReportsStatus { initial, loading, success, error }

extension ExportReportsStatusX on ExportReportsStatus {
  bool get isInitial => this == ExportReportsStatus.initial;
  bool get isLoading => this == ExportReportsStatus.loading;
  bool get isSuccess => this == ExportReportsStatus.success;
  bool get isError => this == ExportReportsStatus.error;
}

enum EditReportStatus { initial, loading, success, error }

extension EditReportStatusX on EditReportStatus {
  bool get isInitial => this == EditReportStatus.initial;
  bool get isLoading => this == EditReportStatus.loading;
  bool get isSuccess => this == EditReportStatus.success;
  bool get isError => this == EditReportStatus.error;
}

enum DeleteReportsStatus { initial, loading, success, error }

extension DeleteReportsStatusX on DeleteReportsStatus {
  bool get isInitial => this == DeleteReportsStatus.initial;
  bool get isLoading => this == DeleteReportsStatus.loading;
  bool get isSuccess => this == DeleteReportsStatus.success;
  bool get isError => this == DeleteReportsStatus.error;
}

enum ReportsStatus { initial, loading, success, error }

extension ReportsStatusX on ReportsStatus {
  bool get isInitial => this == ReportsStatus.initial;
  bool get isLoading => this == ReportsStatus.loading;
  bool get isSuccess => this == ReportsStatus.success;
  bool get isError => this == ReportsStatus.error;
}

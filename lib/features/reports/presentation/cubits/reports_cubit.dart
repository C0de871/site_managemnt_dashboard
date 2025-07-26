import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/core/shared/domain/entities/pagination_entity.dart';
import 'package:site_managemnt_dashboard/features/reports/domain/usecases/export_reports_usecase.dart';
import 'package:site_managemnt_dashboard/features/reports/domain/usecases/get_reports_usecase.dart';
import '../../../../core/databases/params/body.dart';
import '../../../../core/utils/services/service_locator.dart';
import '../../../sites/data/models/sites_model.dart';
import '../../domain/entities/report_entity.dart';
import '../dialogs/report_dialog_service.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final TextEditingController searchController = TextEditingController();
  final dialogService = ReportDialogService();
  VisitType? selectedVisitType;

  final GetReportsUsecase _getReportsUsecase = getIt();
  final ExportReportsUsecase _exportReportsUsecase = getIt();

  ReportsCubit() : super(ReportsState()) {
    searchController.addListener(() {
      searchReports(searchController.text);
    });
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }

  // Mock data - In a real app, this would fetch from an API
  final List<ReportEntity> _allReports = List.generate(
    150,
    (index) => ReportEntity(
      id: index,
      site: SitesModel(
        id: index,
        name: 'Site Name ${index + 1}',
        code: 'SITE${100 + index}',
        longitude: '${index + 1}',
        latitude: '${index + 1}',
      ),
      visitType:
          index % 3 == 0
              ? VisitType.routine
              : (index % 3 == 1 ? VisitType.emergency : VisitType.overhaul),
      visitDate: DateTime.now().subtract(Duration(days: index % 30)),
      username: "",
    ),
  );

  void loadReports({int page = 1}) async {
    emit(state.copyWith(reportsStatus: ReportsStatus.loading));

    final response = await _getReportsUsecase.call(page: page);
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            reportsStatus: ReportsStatus.error,
            fetchReportErrorMessage: failure.errMessage,
          ),
        );
      },
      (reportsResponse) {
        emit(
          ReportsState(
            reports: reportsResponse.reports,
            filteredReports: reportsResponse.reports,
            selectedReportIds: const {},
            pagination: reportsResponse.pagination,
            reportsStatus: ReportsStatus.success,
          ),
        );
      },
    );
  }

  void searchReports(String query) {
    final currentState = state;

    if (query.isEmpty) {
      emit(currentState.copyWith(filteredReports: _allReports));
      return;
    }

    final lowerQuery = query.toLowerCase();
    final filteredReports =
        _allReports.where((report) {
          return report.site.code.toLowerCase().contains(lowerQuery) ||
              report.site.name.toLowerCase().contains(lowerQuery) ||
              report.visitType.arabicName.toLowerCase().contains(lowerQuery);
        }).toList();

    emit(currentState.copyWith(filteredReports: filteredReports));
  }

  void clearSearch() {
    searchController.clear();
    searchReports('');
  }

  void setVisitType(VisitType? type) {
    selectedVisitType = type;
    filterReportsByType(type);
  }

  void filterReportsByType(VisitType? type) {
    final currentState = state;

    if (type == null) {
      emit(currentState.copyWith(filteredReports: _allReports));
      return;
    }

    final filteredReports =
        _allReports.where((report) {
          return report.visitType == type;
        }).toList();

    emit(currentState.copyWith(filteredReports: filteredReports));
  }

  void sortReports({required String field, required bool ascending}) {
    final currentState = state;
    final reports = List<ReportEntity>.from(currentState.filteredReports);

    switch (field) {
      case 'siteCode':
        reports.sort(
          (a, b) =>
              ascending
                  ? a.site.code.compareTo(b.site.code)
                  : b.site.code.compareTo(a.site.code),
        );
        break;
      case 'siteName':
        reports.sort(
          (a, b) =>
              ascending
                  ? a.site.name.compareTo(b.site.name)
                  : b.site.name.compareTo(a.site.name),
        );
        break;
      case 'visitType':
        reports.sort(
          (a, b) =>
              ascending
                  ? a.visitType.index.compareTo(b.visitType.index)
                  : b.visitType.index.compareTo(a.visitType.index),
        );
        break;
      case 'visitDate':
        reports.sort(
          (a, b) =>
              ascending
                  ? a.visitDate.compareTo(b.visitDate)
                  : b.visitDate.compareTo(a.visitDate),
        );
        break;
    }

    emit(currentState.copyWith(filteredReports: reports));
  }

  void toggleReportSelection(String reportId) {
    final currentState = state;
    final selectedIds = Set<String>.from(currentState.selectedReportIds);

    if (selectedIds.contains(reportId)) {
      selectedIds.remove(reportId);
    } else {
      selectedIds.add(reportId);
    }

    log(selectedIds.toString());

    emit(currentState.copyWith(selectedReportIds: selectedIds));
  }

  void selectAllReports(bool selected) {
    final currentState = state;
    final Set<String> selectedIds =
        selected ? Set.from(currentState.filteredReports.map((r) => r.id)) : {};

    emit(currentState.copyWith(selectedReportIds: selectedIds));
  }

  void deleteSelectedReports() async {
    final currentState = state;

    log(currentState.selectedReportIds.toString());

    if (currentState.selectedReportIds.isEmpty) {
      return;
    }

    emit(state.copyWith(deleteReportsStatus: DeleteReportsStatus.loading));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Filter out deleted reports
      final updatedReports =
          _allReports
              .where(
                (report) =>
                    !currentState.selectedReportIds.contains(
                      report.id.toString(),
                    ),
              )
              .toList();

      emit(
        state.copyWith(
          reports: updatedReports,
          filteredReports: updatedReports,
          selectedReportIds: const {},
          pagination: PaginationEntity(), //todo
          deleteReportsStatus: DeleteReportsStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          deleteReportsStatus: DeleteReportsStatus.error,
          deleteReportErrorMessage: e.toString(),
        ),
      );
      (e.toString());
    }
  }

  void deleteOneReport(int reportID) async {
    emit(state.copyWith(deleteReportsStatus: DeleteReportsStatus.loading));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Filter out deleted reports
      final updatedReports =
          _allReports.where((report) => report.id != reportID).toList();

      emit(
        state.copyWith(
          reports: updatedReports,
          filteredReports: updatedReports,
          selectedReportIds: const {},
          pagination: PaginationEntity(), //todo
          deleteReportsStatus: DeleteReportsStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          deleteReportsStatus: DeleteReportsStatus.error,
          deleteReportErrorMessage: (e.toString()),
        ),
      );
    }
  }

  Future<void> exportReportsToExcel(String startDate, String endDate) async {
    final currentState = state;

    emit(state.copyWith(exportReportsStatus: ExportReportsStatus.loading));
    final body = ExportReportsBody(ids: []);
    final response = await _exportReportsUsecase.call(body: body);
    response.fold(
      (l) => emit(
        state.copyWith(
          exportReportsStatus: ExportReportsStatus.error,
          exportReportErrorMessage: l.errMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          reports: currentState.reports,
          filteredReports: currentState.filteredReports,
          selectedReportIds: currentState.selectedReportIds,
          pagination: currentState.pagination,
          exportReportsStatus: ExportReportsStatus.success,
        ),
      ),
    );
  }

  void showConfirmDeleteDialog([int? reportID]) async {
    final confirmed = await dialogService.showConfirmationDialog(
      title: "Delete selected sites",
      content: "Are you sure you want to delete the selected site?",
    );

    if (confirmed == true) {
      if (reportID != null) {
        deleteOneReport(reportID);
      } else {
        deleteSelectedReports();
      }
    }
  }

  void showLoadingDialog() {
    dialogService.showLoadingDialog();
  }

  void hideDialog() => dialogService.hideDialog();

  void showErrorDialog(String message) =>
      dialogService.showErrorDialog(message);
}

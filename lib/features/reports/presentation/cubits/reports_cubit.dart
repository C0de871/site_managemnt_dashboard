import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:site_managemnt_dashboard/core/shared/domain/entities/pagination_entity.dart';
import 'package:site_managemnt_dashboard/features/reports/domain/usecases/get_reports_usecase.dart';
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

  ReportsCubit() : super(ReportsInitial()) {
    // Load reports on initialization
    loadReports();

    // Listen to search controller changes
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
    ),
  );

  void loadReports() async {
    emit(ReportsLoading());

    final response = await _getReportsUsecase.call();
    response.fold(
      (failure) {
        emit(ReportsError(failure.errMessage));
      },
      (reportsResponse) {
        emit(
          ReportsLoaded(
            reports: reportsResponse.reports,
            filteredReports: reportsResponse.reports,
            selectedReportIds: const {},
            pagination: reportsResponse.pagination,
          ),
        );
      },
    );
  }

  void searchReports(String query) {
    if (state is ReportsLoaded) {
      final currentState = state as ReportsLoaded;

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
    if (state is ReportsLoaded) {
      final currentState = state as ReportsLoaded;

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
  }

  void sortReports({required String field, required bool ascending}) {
    if (state is ReportsLoaded) {
      final currentState = state as ReportsLoaded;
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
  }

  void toggleReportSelection(String reportId) {
    if (state is ReportsLoaded) {
      final currentState = state as ReportsLoaded;
      final selectedIds = Set<String>.from(currentState.selectedReportIds);

      if (selectedIds.contains(reportId)) {
        selectedIds.remove(reportId);
      } else {
        selectedIds.add(reportId);
      }

      log(selectedIds.toString());

      emit(currentState.copyWith(selectedReportIds: selectedIds));
    }
  }

  void selectAllReports(bool selected) {
    if (state is ReportsLoaded) {
      final currentState = state as ReportsLoaded;
      final Set<String> selectedIds =
          selected
              ? Set.from(currentState.filteredReports.map((r) => r.id))
              : {};

      emit(currentState.copyWith(selectedReportIds: selectedIds));
    }
  }

  void deleteSelectedReports() async {
    if (state is ReportsLoaded) {
      final currentState = state as ReportsLoaded;

      log(currentState.selectedReportIds.toString());

      if (currentState.selectedReportIds.isEmpty) {
        return;
      }

      emit(
        ReportsActionInProgress(
          baseState: currentState,
          action: 'Deleting selected reports',
        ),
      );

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
          ReportsActionSuccess(
            reports: updatedReports,
            filteredReports: updatedReports,
            selectedReportIds: const {},
            pagination: PaginationEntity(), //todo
          ),
        );
      } catch (e) {
        emit(ReportsError(e.toString()));
      }
    }
  }

  void deleteOneReport(int reportID) async {
    if (state is ReportsLoaded) {
      final currentState = state as ReportsLoaded;

      emit(
        ReportsActionInProgress(
          baseState: currentState,
          action: 'Deleting selected reports',
        ),
      );

      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));

        // Filter out deleted reports
        final updatedReports =
            _allReports.where((report) => report.id != reportID).toList();

        emit(
          ReportsActionSuccess(
            reports: updatedReports,
            filteredReports: updatedReports,
            selectedReportIds: const {},
            pagination: PaginationEntity(), //todo
          ),
        );
      } catch (e) {
        emit(ReportsError(e.toString()));
      }
    }
  }

  void exportReportsToExcel() async {
    if (state is ReportsLoaded) {
      final currentState = state as ReportsLoaded;

      emit(
        ReportsActionInProgress(
          baseState: currentState,
          action: 'Exporting to Excel',
        ),
      );

      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));

        // In real app, this would be an API call to backend

        emit(currentState);
      } catch (e) {
        emit(ReportsError(e.toString()));
      }
    }
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

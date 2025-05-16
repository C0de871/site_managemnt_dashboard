import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/report_entity.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final TextEditingController searchController = TextEditingController();
  VisitType? selectedVisitType;

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
      code: 'SITE${100 + index}',
      name: 'Site Name ${index + 1}',
      visitType:
          index % 3 == 0
              ? VisitType.routine
              : (index % 3 == 1 ? VisitType.emergency : VisitType.umrah),
      visitDate: DateTime.now().subtract(Duration(days: index % 30)),
    ),
  );

  void loadReports() async {
    emit(ReportsLoading());

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));

      emit(
        ReportsLoaded(
          reports: _allReports,
          filteredReports: _allReports,
          selectedReportIds: const {},
        ),
      );
    } catch (e) {
      emit(ReportsError(e.toString()));
    }
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
            return report.code.toLowerCase().contains(lowerQuery) ||
                report.name.toLowerCase().contains(lowerQuery) ||
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
                ascending ? a.code.compareTo(b.code) : b.code.compareTo(a.code),
          );
          break;
        case 'siteName':
          reports.sort(
            (a, b) =>
                ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name),
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

      if (currentState.selectedReportIds.isEmpty) return;

      emit(
        ReportsActionInProgress(
          baseState: currentState,
          action: 'Deleting selected reports',
        ),
      );

      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));

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
          ReportsLoaded(
            reports: updatedReports,
            filteredReports: updatedReports,
            selectedReportIds: const {},
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
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:site_managemnt_dashboard/core/databases/params/body.dart';
import 'package:site_managemnt_dashboard/features/reports/domain/entities/report_entity.dart';
import 'package:site_managemnt_dashboard/features/reports_details/domain/entities/report_details_entity.dart';
import 'package:site_managemnt_dashboard/features/reports_details/domain/usecases/get_report_details_usecase.dart';

import '../../../../core/utils/services/service_locator.dart';

part 'report_details_state.dart';

class ReportDetailsCubit extends Cubit<ReportDetailsState> {
  ReportDetailsCubit({required this.reportId}) : super(ReportDetailsState());

  final String reportId;

  final GetReportDetailsUsecase _getReportDetailsUsecase = getIt();

  final siteNameController = TextEditingController();
  final siteCodeController = TextEditingController();
  final reportNumberController = TextEditingController();
  final visitTypeController = TextEditingController();
  final visitDateController = TextEditingController();
  final visitTimeController = TextEditingController();

  final temperatureController = TextEditingController();
  final oilPressureController = TextEditingController();
  final batteryVoltageController = TextEditingController();
  final burnedOilQuantityController = TextEditingController();
  final frequencyController = TextEditingController();
  final oilQuantityController = TextEditingController();

  final visitResonsController = TextEditingController();
  final technicalConditionController = TextEditingController();
  final technicianNotesController = TextEditingController();

  final siteLocationController = TextEditingController();

  final generatorBrandController = TextEditingController();
  final engineBrandController = TextEditingController();
  final engineCapacityController = TextEditingController();
  final counterReadingController = TextEditingController();
  final lastCounterReadingController = TextEditingController();
  final cablesStatusController = TextEditingController();
  final lastVisitDateController = TextEditingController();

  final batteryVoltage1Controller = TextEditingController();
  final batteryVoltage2Controller = TextEditingController();
  final batteryVoltage3Controller = TextEditingController();

  final batteryLoad1Controller = TextEditingController();
  final batteryLoad2Controller = TextEditingController();
  final batteryLoad3Controller = TextEditingController();

  final List<TextEditingController> completedTasksControllers = [];

  final List<MaterialsControllersModel> materialsControllers = [];

  void loadReportDetails() async {
    GetReportByIDBody body = GetReportByIDBody(id: reportId);
    emit(state.copyWith(reportDetailsStatus: ReportDetailsStatus.loading));
    final result = await _getReportDetailsUsecase(body);
    result.fold(
      (failure) => emit(
        state.copyWith(
          reportDetailsStatus: ReportDetailsStatus.error,
          loadReportErrorMsg: failure.errMessage,
        ),
      ),
      (reportDetails) {
        _initControllers(reportDetails);
        emit(
          state.copyWith(
            reportDetails: reportDetails,
            reportDetailsStatus: ReportDetailsStatus.loaded,
          ),
        );
      },
    );
  }

  void _initControllers(ReportDetailsEntity reportDetails) {
    String formattedDate = DateFormat(
      'yyyy-MM-dd',
    ).format(reportDetails.visitDateAndTime);
    String formattedTime = DateFormat(
      'HH:mm:ss',
    ).format(reportDetails.visitDateAndTime);

    String? formattedLastVisitDate =
        reportDetails.lastRoutineVisitDate == null
            ? ''
            : DateFormat(
              'yyyy-MM-dd',
            ).format(reportDetails.lastRoutineVisitDate!);

    siteNameController.text = reportDetails.generator.site?.name ?? '';
    siteCodeController.text = reportDetails.generator.site?.code ?? '';
    reportNumberController.text = reportDetails.reportNumber ?? '';
    visitTypeController.text = reportDetails.visitType.arabicName ?? '';
    visitDateController.text = formattedDate;
    visitTimeController.text = formattedTime;
    temperatureController.text = reportDetails.temperature ?? '';
    oilPressureController.text = reportDetails.oilPressure ?? '';
    batteryVoltageController.text = reportDetails.batteryVoltage ?? '';
    burnedOilQuantityController.text = reportDetails.burnedOilQuantity ?? '';
    frequencyController.text = reportDetails.frequency ?? '';
    oilQuantityController.text = reportDetails.oilQuantity ?? '';

    visitResonsController.text = reportDetails.visitReason ?? '';
    technicalConditionController.text = reportDetails.technicalStatus ?? '';
    technicianNotesController.text = reportDetails.technicianNotes
        .map((note) {
          return note.note;
        })
        .toList()
        .join(', ');

    siteLocationController.text =
        "${reportDetails.longitude} ${reportDetails.latitude}" ?? '';

    generatorBrandController.text = reportDetails.generator.brand?.brand ?? '';
    engineBrandController.text =
        reportDetails.generator.engine.engineBrand.brand ?? '';
    engineCapacityController.text =
        reportDetails.generator.engine.engineCapacity.capacity.toString() ?? '';
    counterReadingController.text = reportDetails.currentMeter ?? '';
    lastCounterReadingController.text = reportDetails.lastMeter ?? '';
    cablesStatusController.text = reportDetails.atsStatus ?? '';
    lastVisitDateController.text = formattedLastVisitDate ?? '';

    batteryVoltage1Controller.text = reportDetails.voltL1 ?? '';
    batteryVoltage2Controller.text = reportDetails.voltL2 ?? '';
    batteryVoltage3Controller.text = reportDetails.voltL3 ?? '';

    batteryLoad1Controller.text = reportDetails.loadL1 ?? '';
    batteryLoad2Controller.text = reportDetails.loadL2 ?? '';
    batteryLoad3Controller.text = reportDetails.loadL3 ?? '';

    completedTasksControllers.addAll(
      List.generate(reportDetails.completedWorks.length, (index) {
        return TextEditingController(
          text: reportDetails.completedWorks[index].description,
        );
      }),
    );
  }
}

class MaterialsControllersModel {
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final codeController = TextEditingController();
  final notesController = TextEditingController();
  final isFaultyController = TextEditingController();
  final lastReplacementDateController = TextEditingController();
}

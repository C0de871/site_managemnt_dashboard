import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'report_details_state.dart';

class ReportDetailsCubit extends Cubit<ReportDetailsState> {
  ReportDetailsCubit() : super(ReportDetailsInitial());

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

  final List<TextEditingController> completedWorksController = [];

  final List<MaterialsControllersModel> materialsControllers = [];
}

class MaterialsControllersModel {
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final codeController = TextEditingController();
  final notesController = TextEditingController();
  final isFaultyController = TextEditingController();
  final lastReplacementDateController = TextEditingController();
}

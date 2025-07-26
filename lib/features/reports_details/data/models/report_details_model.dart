import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:site_managemnt_dashboard/features/reports/domain/entities/report_entity.dart';
import 'package:site_managemnt_dashboard/features/reports_details/domain/entities/report_details_entity.dart';

import '../../../../core/utils/constants/constant.dart';
import '../../../generators/data/models/generator_model.dart';
import '../../../parts/data/models/part_model.dart';
import 'completed_work_model.dart';
import 'technician_note_model.dart';

class ReportDetailsModel extends ReportDetailsEntity {
  const ReportDetailsModel({
    required super.id,
    required super.generator,
    required super.visitType,
    required super.reportNumber,
    required super.visitDateAndTime,
    required super.oilPressure,
    required super.temperature,
    required super.batteryVoltage,
    required super.oilQuantity,
    required super.burnedOilQuantity,
    required super.frequency,
    required super.currentMeter,
    required super.atsStatus,
    required super.voltL1,
    required super.voltL2,
    required super.voltL3,
    required super.loadL1,
    required super.loadL2,
    required super.loadL3,
    required super.visitReason,
    required super.longitude,
    required super.latitude,
    required super.lastMeter,
    required super.lastRoutineVisitDate,
    required super.technicianNotes,
    required super.technicalStatus,
    required super.completedWorks,
    required super.parts,
    required super.username,
  });

  static const String kId = 'id';
  static const String kGenerator = 'generator';
  static const String kVisitType = 'visit_type';
  static const String kReportNumber = 'report_number';
  static const String kVisitDate = 'visit_date';
  static const String kVisitTime = 'visit_time';
  static const String kOilPressure = 'oil_pressure';
  static const String kTemperature = 'temperature';
  static const String kBatteryVoltage = 'battery_voltage';
  static const String kOilQuantity = 'oil_quantity';
  static const String kBurnedOilQuantity = 'burned_oil_quantity';
  static const String kFrequency = 'frequency';
  static const String kCurrentMeter = 'current_meter';
  static const String kAtsStatus = 'ats_status';
  static const String kVoltL1 = 'volt_l1';
  static const String kVoltL2 = 'volt_l2';
  static const String kVoltL3 = 'volt_l3';
  static const String kLoadL1 = 'load_l1';
  static const String kLoadL2 = 'load_l2';
  static const String kLoadL3 = 'load_l3';
  static const String kVisitReason = 'visit_reason';
  static const String kLongitude = 'longitude';
  static const String kLatitude = 'latitude';
  static const String kLastMeter = 'last_meter';
  static const String kLastRoutineVisitDate = 'last_routine_visit_date';
  static const String kTechnicianNotes = 'technician_notes';
  static const String kTechnicalStatus = 'technical_status';
  static const String kCompletedWorks = 'completed_works';
  static const String kParts = 'parts';
  static const String usernameKey = 'username';

  factory ReportDetailsModel.fromJson(Map<String, dynamic> json) {
    log("visited date: ${json[kVisitDate]}");
    log("visited time: ${json[kVisitTime]}");
    final DateTime visitDateAndTime = DateTime.parse(
      "${json[kVisitDate]} ${json[kVisitTime]}",
    );

    final DateTime? lastVisitDate =
        json[kLastRoutineVisitDate] == null
            ? null
            : DateTime.tryParse(json[kLastRoutineVisitDate]);

    return ReportDetailsModel(
      id: json[kId],
      generator: GeneratorModel.fromJson(json[kGenerator]),
      visitType: (json[kVisitType] as String).visitType,
      reportNumber: json[kReportNumber],
      visitDateAndTime: visitDateAndTime,
      oilPressure: json[kOilPressure],
      temperature: json[kTemperature],
      batteryVoltage: json[kBatteryVoltage],
      oilQuantity: json[kOilQuantity],
      burnedOilQuantity: json[kBurnedOilQuantity],
      frequency: json[kFrequency],
      currentMeter: json[kCurrentMeter],
      atsStatus:
          (json[kAtsStatus] as bool?) == null
              ? null
              : (json[kAtsStatus] as bool) == true
              ? Constant.ok
              : Constant.notOk,
      voltL1: json[kVoltL1],
      voltL2: json[kVoltL2],
      voltL3: json[kVoltL3],
      loadL1: json[kLoadL1],
      loadL2: json[kLoadL2],
      loadL3: json[kLoadL3],
      visitReason: json[kVisitReason],
      longitude: json[kLongitude],
      latitude: json[kLatitude],
      lastMeter: json[kLastMeter],
      lastRoutineVisitDate: lastVisitDate,
      technicianNotes:
          (json[kTechnicianNotes] as List)
              .map((e) => TechnicianNoteModel.fromJson(e))
              .toList(),
      technicalStatus: json[kTechnicalStatus],
      completedWorks:
          (json[kCompletedWorks] as List)
              .map((e) => CompletedWorkModel.fromJson(e))
              .toList(),
      parts: (json[kParts] as List).map((e) => PartModel.fromJson(e)).toList(),
      username: json[usernameKey] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    String formattedDate = DateFormat(
      'yyyy-MM-dd',
    ).format(super.visitDateAndTime);
    String formattedTime = DateFormat(
      'HH:mm:ss',
    ).format(super.visitDateAndTime);
    return {
      kId: id,
      kGenerator: (generator as GeneratorModel).toJson(),
      kVisitType: visitType.englishName,
      kReportNumber: reportNumber,
      kVisitDate: formattedDate,
      kVisitTime: formattedTime,
      kOilPressure: oilPressure,
      kTemperature: temperature,
      kBatteryVoltage: batteryVoltage,
      kOilQuantity: oilQuantity,
      kBurnedOilQuantity: burnedOilQuantity,
      kFrequency: frequency,
      kCurrentMeter: currentMeter,
      kAtsStatus: atsStatus,
      kVoltL1: voltL1,
      kVoltL2: voltL2,
      kVoltL3: voltL3,
      kLoadL1: loadL1,
      kLoadL2: loadL2,
      kLoadL3: loadL3,
      kVisitReason: visitReason,
      kLongitude: longitude,
      kLatitude: latitude,
      kLastMeter: lastMeter,
      kLastRoutineVisitDate: lastRoutineVisitDate,
      kTechnicianNotes:
          technicianNotes
              .map((e) => (e as TechnicianNoteModel).toJson())
              .toList(),
      kTechnicalStatus: technicalStatus,
      kCompletedWorks:
          completedWorks
              .map((e) => (e as CompletedWorkModel).toJson())
              .toList(),
      kParts: parts.map((e) => (e as PartModel).toJson()).toList(),
      usernameKey: username,
    };
  }
}

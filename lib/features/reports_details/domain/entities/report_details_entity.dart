// domain/entities/visit_entity.dart
import 'package:equatable/equatable.dart';

import '../../../generators/domain/entities/generator_entity.dart';
import '../../../reports/domain/entities/report_entity.dart';
import '../../domain/entities/completed_work_entity.dart';
import '../../domain/entities/technician_note_entity.dart';
import '../../../parts/domain/entities/part_entity.dart'; // Assuming it's created

class ReportDetailsEntity extends Equatable {
  final int id;
  final GeneratorEntity generator;
  final VisitType visitType;
  final String reportNumber;
  final DateTime visitDateAndTime;
  // final String visitTime;
  final String oilPressure;
  final String temperature;
  final String batteryVoltage;
  final String oilQuantity;
  final String burnedOilQuantity;
  final String frequency;
  final String currentMeter;
  final String? atsStatus;
  final String voltL1;
  final String voltL2;
  final String voltL3;
  final String loadL1;
  final String loadL2;
  final String loadL3;
  final String visitReason;
  final String longitude;
  final String latitude;
  final String? lastMeter;
  final DateTime? lastRoutineVisitDate;
  final List<TechnicianNoteEntity> technicianNotes;
  final String technicalStatus;
  final List<CompletedWorkEntity> completedWorks;
  final List<PartEntity> parts;

  const ReportDetailsEntity({
    required this.id,
    required this.generator,
    required this.visitType,
    required this.reportNumber,
    required this.visitDateAndTime,
    // required this.visitTime,
    required this.oilPressure,
    required this.temperature,
    required this.batteryVoltage,
    required this.oilQuantity,
    required this.burnedOilQuantity,
    required this.frequency,
    required this.currentMeter,
    required this.atsStatus,
    required this.voltL1,
    required this.voltL2,
    required this.voltL3,
    required this.loadL1,
    required this.loadL2,
    required this.loadL3,
    required this.visitReason,
    required this.longitude,
    required this.latitude,
    required this.lastMeter,
    required this.lastRoutineVisitDate,
    required this.technicianNotes,
    required this.technicalStatus,
    required this.completedWorks,
    required this.parts,
  });

  ReportDetailsEntity copyWith({
    int? id,
    GeneratorEntity? generator,
    VisitType? visitType,
    String? reportNumber,
    DateTime? visitDateAndTime,
    // String? visitTime,
    String? oilPressure,
    String? temperature,
    String? batteryVoltage,
    String? oilQuantity,
    String? burnedOilQuantity,
    String? frequency,
    String? currentMeter,
    String? atsStatus,
    String? voltL1,
    String? voltL2,
    String? voltL3,
    String? loadL1,
    String? loadL2,
    String? loadL3,
    String? visitReason,
    String? longitude,
    String? latitude,
    String? lastMeter,
    DateTime? lastRoutineVisitDate,
    List<TechnicianNoteEntity>? technicianNotes,
    String? technicalStatus,
    List<CompletedWorkEntity>? completedWorks,
    List<PartEntity>? parts,
  }) {
    return ReportDetailsEntity(
      id: id ?? this.id,
      generator: generator ?? this.generator,
      visitType: visitType ?? this.visitType,
      reportNumber: reportNumber ?? this.reportNumber,
      visitDateAndTime: visitDateAndTime ?? this.visitDateAndTime,
      // visitTime: visitTime ?? this.visitTime,
      oilPressure: oilPressure ?? this.oilPressure,
      temperature: temperature ?? this.temperature,
      batteryVoltage: batteryVoltage ?? this.batteryVoltage,
      oilQuantity: oilQuantity ?? this.oilQuantity,
      burnedOilQuantity: burnedOilQuantity ?? this.burnedOilQuantity,
      frequency: frequency ?? this.frequency,
      currentMeter: currentMeter ?? this.currentMeter,
      atsStatus: atsStatus ?? this.atsStatus,
      voltL1: voltL1 ?? this.voltL1,
      voltL2: voltL2 ?? this.voltL2,
      voltL3: voltL3 ?? this.voltL3,
      loadL1: loadL1 ?? this.loadL1,
      loadL2: loadL2 ?? this.loadL2,
      loadL3: loadL3 ?? this.loadL3,
      visitReason: visitReason ?? this.visitReason,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      lastMeter: lastMeter ?? this.lastMeter,
      lastRoutineVisitDate: lastRoutineVisitDate ?? this.lastRoutineVisitDate,
      technicianNotes: technicianNotes ?? this.technicianNotes,
      technicalStatus: technicalStatus ?? this.technicalStatus,
      completedWorks: completedWorks ?? this.completedWorks,
      parts: parts ?? this.parts,
    );
  }

  @override
  List<Object?> get props => [
    id,
    generator,
    visitType,
    reportNumber,
    visitDateAndTime,
    // visitTime,
    oilPressure,
    temperature,
    batteryVoltage,
    oilQuantity,
    burnedOilQuantity,
    frequency,
    currentMeter,
    atsStatus,
    voltL1,
    voltL2,
    voltL3,
    loadL1,
    loadL2,
    loadL3,
    visitReason,
    longitude,
    latitude,
    lastMeter,
    lastRoutineVisitDate,
    technicianNotes,
    technicalStatus,
    completedWorks,
    parts,
  ];
}

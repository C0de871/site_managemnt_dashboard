import 'package:equatable/equatable.dart';
import 'package:site_managemnt_dashboard/features/generators/domain/entities/generator_entity.dart';

import '../../../reports/domain/entities/report_entity.dart';

class ReportPartEntity extends Equatable {
  final int id;
  final String name;
  final int quantity;
  final String code;
  final String note;
  final bool isFaulty;
  final DateTime lastReplacementDate;
  final double lastReplacementMeter;

  const ReportPartEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.code,
    required this.note,
    required this.isFaulty,
    required this.lastReplacementDate,
    required this.lastReplacementMeter,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    quantity,
    code,
    note,
    isFaulty,
    lastReplacementDate,
    lastReplacementMeter,
  ];

  ReportPartEntity copyWith({
    int? id,
    String? name,
    int? quantity,
    String? code,
    String? note,
    bool? isFaulty,
    DateTime? lastReplacementDate,
    double? lastReplacementMeter,
  }) {
    return ReportPartEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      code: code ?? this.code,
      note: note ?? this.note,
      isFaulty: isFaulty ?? this.isFaulty,
      lastReplacementDate: lastReplacementDate ?? this.lastReplacementDate,
      lastReplacementMeter: lastReplacementMeter ?? this.lastReplacementMeter,
    );
  }
}

enum AtsStatus { ok, notOk }

class ReportDetailsEntity extends Equatable {
  final int id;
  final GeneratorEntity generator;
  final VisitType visitType;
  final String reportNumber;
  final DateTime visitDate;
  final String visitTime;
  final double oilPressure;
  final double temperature;
  final double batterVolt;
  final double oilQuantity;
  final double burnedOilQuantity;
  final double frequency;
  final double meter;
  final double lastMeter;
  final AtsStatus atsStatus;
  final DateTime lastVisitDate;
  final double voltL1;
  final double voltL2;
  final double voltL3;
  final double loadL1;
  final double loadL2;
  final double loadL3;
  final String visitResons;
  final List<String> technicianNotes;
  final String technicalStatus;
  final List<String> completedWorks;
  final List<ReportPartEntity> parts;

  static const String ok = 'ok';
  static const String notOk = 'not ok';

  const ReportDetailsEntity({
    required this.id,
    required this.generator,
    required this.visitType,
    required this.reportNumber,
    required this.visitDate,
    required this.visitTime,
    required this.oilPressure,
    required this.temperature,
    required this.batterVolt,
    required this.oilQuantity,
    required this.burnedOilQuantity,
    required this.frequency,
    required this.meter,
    required this.lastMeter,
    required this.atsStatus,
    required this.lastVisitDate,
    required this.voltL1,
    required this.voltL2,
    required this.voltL3,
    required this.loadL1,
    required this.loadL2,
    required this.loadL3,
    required this.visitResons,
    required this.technicianNotes,
    required this.technicalStatus,
    required this.completedWorks,
    required this.parts,
  });

  @override
  List<Object?> get props => [
    id,
    generator,
    visitType,
    reportNumber,
    visitDate,
    visitTime,
    oilPressure,
    temperature,
    batterVolt,
    oilQuantity,
    burnedOilQuantity,
    frequency,
    meter,
    lastMeter,
    atsStatus,
    lastVisitDate,
    voltL1,
    voltL2,
    voltL3,
    loadL1,
    loadL2,
    loadL3,
    visitResons,
    technicianNotes,
    technicalStatus,
    completedWorks,
    parts,
  ];

  //creat copy with
  ReportDetailsEntity copyWith({
    int? id,
    GeneratorEntity? generator,
    VisitType? visitType,
    String? reportNumber,
    DateTime? visitDate,
    String? visitTime,
    double? oilPressure,
    double? temperature,
    double? batterVolt,
    double? oilQuantity,
    double? burnedOilQuantity,
    double? frequency,
    double? meter,
    double? lastMeter,
    AtsStatus? atsStatus,
    DateTime? lastVisitDate,
    double? voltL1,
    double? voltL2,
    double? voltL3,
    double? loadL1,
    double? loadL2,
    double? loadL3,
    String? visitResons,
    List<String>? technicianNotes,
    String? technicalStatus,
    List<String>? completedWorks,
    String? visitLocation,
    List<ReportPartEntity>? parts,
  }) {
    return ReportDetailsEntity(
      id: id ?? this.id,
      generator: generator ?? this.generator,
      visitType: visitType ?? this.visitType,
      reportNumber: reportNumber ?? this.reportNumber,
      visitDate: visitDate ?? this.visitDate,
      visitTime: visitTime ?? this.visitTime,
      oilPressure: oilPressure ?? this.oilPressure,
      temperature: temperature ?? this.temperature,
      batterVolt: batterVolt ?? this.batterVolt,
      oilQuantity: oilQuantity ?? this.oilQuantity,
      burnedOilQuantity: burnedOilQuantity ?? this.burnedOilQuantity,
      frequency: frequency ?? this.frequency,
      meter: meter ?? this.meter,
      lastMeter: lastMeter ?? this.lastMeter,
      atsStatus: atsStatus ?? this.atsStatus,
      lastVisitDate: lastVisitDate ?? this.lastVisitDate,
      voltL1: voltL1 ?? this.voltL1,
      voltL2: voltL2 ?? this.voltL2,
      voltL3: voltL3 ?? this.voltL3,
      loadL1: loadL1 ?? this.loadL1,
      loadL2: loadL2 ?? this.loadL2,
      loadL3: loadL3 ?? this.loadL3,
      visitResons: visitResons ?? this.visitResons,
      technicianNotes: technicianNotes ?? this.technicianNotes,
      technicalStatus: technicalStatus ?? this.technicalStatus,
      completedWorks: completedWorks ?? this.completedWorks,
      parts: parts ?? this.parts,
    );
  }
}

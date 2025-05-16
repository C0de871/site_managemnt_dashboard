import '../../../generators/data/models/generator_model.dart';
import '../../domain/entities/report_details_entity.dart';

class ReportPartModel extends ReportPartEntity {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String quantityKey = 'quantity';
  static const String codeKey = 'code';
  static const String noteKey = 'note';
  static const String isFaultyKey = 'is_faulty';
  static const String lastReplacementDateKey = 'last_replacement_date';

  const ReportPartModel({
    required super.id,
    required super.name,
    required super.quantity,
    required super.code,
    required super.note,
    required super.isFaulty,
    required super.lastReplacementDate,
  });

  factory ReportPartModel.fromJson(Map<String, dynamic> json) {
    return ReportPartModel(
      id: json[idKey] as int,
      name: json[nameKey] as String,
      quantity: json[quantityKey] as int,
      code: json[codeKey] as String,
      note: json[noteKey] as String,
      isFaulty: json[isFaultyKey] as bool,
      lastReplacementDate: DateTime.parse(
        json[lastReplacementDateKey] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      idKey: id,
      nameKey: name,
      quantityKey: quantity,
      codeKey: code,
      noteKey: note,
      isFaultyKey: isFaulty,
      lastReplacementDateKey: lastReplacementDate.toIso8601String(),
    };
  }
}

class ReportDetailsModel extends ReportDetailsEntity {
  static const String idKey = 'id';
  static const String generatorKey = 'generator';
  static const String visitTypeKey = 'visit_type';
  static const String reportNumberKey = 'report_number';
  static const String visitDateKey = 'visit_date';
  static const String visitTimeKey = 'visit_time';
  static const String oilPressureKey = 'oil_pressure';
  static const String temperatureKey = 'temperature';
  static const String batterVoltKey = 'batter_volt';
  static const String oilQuantityKey = 'oil_quantity';
  static const String burnedOilQuantityKey = 'burned_oil_quantity';
  static const String frequencyKey = 'frequency';
  static const String generatorBrandKey = 'generator_brand';
  static const String engineBrandKey = 'engine_brand';
  static const String engineCapacityKey = 'engine_capacity';
  static const String meterKey = 'meter';
  static const String lastMeterKey = 'last_meter';
  static const String atsStatusKey = 'ats_status';
  static const String lastVisitDateKey = 'last_visit_date';
  static const String voltL1Key = 'volt_l1';
  static const String voltL2Key = 'volt_l2';
  static const String voltL3Key = 'volt_l3';
  static const String loadL1Key = 'load_l1';
  static const String loadL2Key = 'load_l2';
  static const String loadL3Key = 'load_l3';
  static const String visitResonsKey = 'visit_resons';
  static const String technicianNotesKey = 'technician_notes';
  static const String technicalStatusKey = 'technical_status';
  static const String completedWorksKey = 'completed_works';
  static const String visitLocationKey = 'visit_location';
  static const String partsKey = 'parts';

  const ReportDetailsModel({
    required super.id,
    required super.generator,
    required super.visitType,
    required super.reportNumber,
    required super.visitDate,
    required super.visitTime,
    required super.oilPressure,
    required super.temperature,
    required super.batterVolt,
    required super.oilQuantity,
    required super.burnedOilQuantity,
    required super.frequency,
    required super.meter,
    required super.lastMeter,
    required super.atsStatus,
    required super.lastVisitDate,
    required super.voltL1,
    required super.voltL2,
    required super.voltL3,
    required super.loadL1,
    required super.loadL2,
    required super.loadL3,
    required super.visitResons,
    required super.technicianNotes,
    required super.technicalStatus,
    required super.completedWorks,
    required super.visitLocation,
    required super.parts,
  });

  factory ReportDetailsModel.fromJson(Map<String, dynamic> json) {
    return ReportDetailsModel(
      id: json[idKey] as int,
      generator: GeneratorModel.fromJson(json[generatorKey] as Map<String, dynamic>),
      visitType: json[visitTypeKey] as String,
      reportNumber: json[reportNumberKey] as String,
      visitDate: DateTime.parse(json[visitDateKey] as String),
      visitTime: json[visitTimeKey] as String,
      oilPressure: (json[oilPressureKey] as num).toDouble(),
      temperature: (json[temperatureKey] as num).toDouble(),
      batterVolt: (json[batterVoltKey] as num).toDouble(),
      oilQuantity: (json[oilQuantityKey] as num).toDouble(),
      burnedOilQuantity: (json[burnedOilQuantityKey] as num).toDouble(),
      frequency: (json[frequencyKey] as num).toDouble(),
      meter: (json[meterKey] as num).toDouble(),
      lastMeter: (json[lastMeterKey] as num).toDouble(),
      atsStatus: _parseAtsStatus(json[atsStatusKey] as String),
      lastVisitDate: DateTime.parse(json[lastVisitDateKey] as String),
      voltL1: (json[voltL1Key] as num).toDouble(),
      voltL2: (json[voltL2Key] as num).toDouble(),
      voltL3: (json[voltL3Key] as num).toDouble(),
      loadL1: (json[loadL1Key] as num).toDouble(),
      loadL2: (json[loadL2Key] as num).toDouble(),
      loadL3: (json[loadL3Key] as num).toDouble(),
      visitResons: json[visitResonsKey] as String,
      technicianNotes: List<String>.from(json[technicianNotesKey] as List),
      technicalStatus: json[technicalStatusKey] as String,
      completedWorks: List<String>.from(json[completedWorksKey] as List),
      visitLocation: json[visitLocationKey] as String,
      parts:
          (json[partsKey] as List)
              .map(
                (part) =>
                    ReportPartModel.fromJson(part as Map<String, dynamic>),
              )
              .toList(),
    );
  }

  static AtsStatus _parseAtsStatus(String status) {
    switch (status) {
      case ReportDetailsEntity.ok:
        return AtsStatus.ok;
      case ReportDetailsEntity.notOk:
        return AtsStatus.notOk;
      default:
        return AtsStatus.ok;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      idKey: id,
      generatorKey: generator,
      visitTypeKey: visitType,
      reportNumberKey: reportNumber,
      visitDateKey: visitDate.toIso8601String(),
      visitTimeKey: visitTime,
      oilPressureKey: oilPressure,
      temperatureKey: temperature,
      batterVoltKey: batterVolt,
      oilQuantityKey: oilQuantity,
      burnedOilQuantityKey: burnedOilQuantity,
      frequencyKey: frequency,
      meterKey: meter,
      lastMeterKey: lastMeter,
      atsStatusKey: atsStatus,
      lastVisitDateKey: lastVisitDate.toIso8601String(),
      voltL1Key: voltL1,
      voltL2Key: voltL2,
      voltL3Key: voltL3,
      loadL1Key: loadL1,
      loadL2Key: loadL2,
      loadL3Key: loadL3,
      visitResonsKey: visitResons,
      technicianNotesKey: technicianNotes,
      technicalStatusKey: technicalStatus,
      completedWorksKey: completedWorks,
      visitLocationKey: visitLocation,
      partsKey:
          parts.map((part) => (part as ReportPartModel).toJson()).toList(),
    };
  }
}

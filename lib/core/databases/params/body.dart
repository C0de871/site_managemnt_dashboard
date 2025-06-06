abstract class Body {
  Map<String, dynamic> toMap();
}

class GetReportByIDBody {
  final String id;

  static const String idKey = 'id';

  GetReportByIDBody({required this.id});

  Map<String, dynamic> toMap() {
    return {idKey: id};
  }
}

class AddSiteBody {
  final String name;
  final String code;
  final String longitude;
  final String latitude;

  static const String nameKey = 'name';
  static const String codeKey = 'code';
  static const String longitudeKey = 'longitude';
  static const String latitudeKey = 'latitude';

  AddSiteBody({
    required this.name,
    required this.code,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toMap() {
    return {
      nameKey: name,
      codeKey: code,
      longitudeKey: longitude,
      latitudeKey: latitude,
    };
  }
}

class AddPartBody {
  final String name;
  final String code;
  final String isGeneral;
  final String engineId;

  static const String nameKey = 'name';
  static const String codeKey = 'code';
  static const String isGeneralKey = 'is_general';
  static const String engineIdKey = 'engine_id';

  AddPartBody({
    required this.name,
    required this.code,
    required this.isGeneral,
    required this.engineId,
  });

  Map<String, dynamic> toMap() {
    return {
      nameKey: name,
      codeKey: code,
      isGeneralKey: isGeneral,
      engineIdKey: engineId,
    };
  }
}

class AddGeneratorBrandBody {
  final String brand;

  static const String brandKey = 'brand';

  AddGeneratorBrandBody({required this.brand});

  Map<String, dynamic> toMap() {
    return {brandKey: brand};
  }
}

class CreateGeneratorBody {
  final String generatorBrandId;
  final String engineId;
  final String initalMeter;
  final String siteId;

  static const String generatorBrandIdKey = 'generator_brand_id';
  static const String engineIdKey = 'engine_id';
  static const String initalMeterKey = 'inital_meter';
  static const String siteIdKey = 'site_id';

  CreateGeneratorBody({
    required this.generatorBrandId,
    required this.engineId,
    required this.initalMeter,
    required this.siteId,
  });

  Map<String, dynamic> toMap() {
    return {
      generatorBrandIdKey: generatorBrandId,
      engineIdKey: engineId,
      initalMeterKey: initalMeter,
      siteIdKey: siteId,
    };
  }
}

class AddEngineBrandBody {
  final String brand;

  static const String brandKey = 'brand';

  AddEngineBrandBody({required this.brand});

  Map<String, dynamic> toMap() {
    return {brandKey: brand};
  }
}

class AddEngineCapacityBody {
  final String capacity;

  static const String capacityKey = 'capacity';

  AddEngineCapacityBody({required this.capacity});

  Map<String, dynamic> toMap() {
    return {capacityKey: capacity};
  }
}

class CreateEngineBody {
  final String engineBrandId;
  final String engineCapacityId;

  static const String engineBrandIdKey = 'engine_brand_id';
  static const String engineCapacityIdKey = 'engine_capacity_id';

  CreateEngineBody({
    required this.engineBrandId,
    required this.engineCapacityId,
  });

  Map<String, dynamic> toMap() {
    return {
      engineBrandIdKey: engineBrandId,
      engineCapacityIdKey: engineCapacityId,
    };
  }
}

class EditSiteBody {
  final String id;
  final String name;
  final String code;
  final String longitude;
  final String latitude;

  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String codeKey = 'code';
  static const String longitudeKey = 'longitude';
  static const String latitudeKey = 'latitude';

  EditSiteBody({
    required this.id,
    required this.name,
    required this.code,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      nameKey: name,
      codeKey: code,
      longitudeKey: longitude,
      latitudeKey: latitude,
    };
  }
}

class EditGeneratorBody {
  final String id;
  final String generatorBrandId;
  final String engineId;
  final String initalMeter;
  final String siteId;

  static const String idKey = 'id';
  static const String generatorBrandIdKey = 'generator_brand_id';
  static const String engineIdKey = 'engine_id';
  static const String initalMeterKey = 'inital_meter';
  static const String siteIdKey = 'site_id';

  EditGeneratorBody({
    required this.id,
    required this.generatorBrandId,
    required this.engineId,
    required this.initalMeter,
    required this.siteId,
  });

  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      generatorBrandIdKey: generatorBrandId,
      engineIdKey: engineId,
      initalMeterKey: initalMeter,
      siteIdKey: siteId,
    };
  }
}

class EditEngineBody {
  final String id;
  final String engineBrandId;
  final String engineCapacityId;

  static const String idKey = 'id';
  static const String engineBrandIdKey = 'engine_brand_id';
  static const String engineCapacityIdKey = 'engine_capacity_id';

  EditEngineBody({
    required this.id,
    required this.engineBrandId,
    required this.engineCapacityId,
  });

  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      engineBrandIdKey: engineBrandId,
      engineCapacityIdKey: engineCapacityId,
    };
  }
}

class EditPartBody {
  final String id;
  final String name;
  final String code;
  final String isGeneral;
  final String engineId;

  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String codeKey = 'code';
  static const String isGeneralKey = 'is_general';
  static const String engineIdKey = 'engine_id';

  EditPartBody({
    required this.id,
    required this.name,
    required this.code,
    required this.isGeneral,
    required this.engineId,
  });

  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      nameKey: name,
      codeKey: code,
      isGeneralKey: isGeneral,
      engineIdKey: engineId,
    };
  }
}

class EditGeneratorBrandBody {
  final String id;
  final String brand;

  static const String idKey = 'id';
  static const String brandKey = 'brand';

  EditGeneratorBrandBody({required this.id, required this.brand});

  Map<String, dynamic> toMap() {
    return {idKey: id, brandKey: brand};
  }
}

class EditEngineBrandBody {
  final String id;
  final String brand;

  static const String idKey = 'id';
  static const String brandKey = 'brand';

  EditEngineBrandBody({required this.id, required this.brand});

  Map<String, dynamic> toMap() {
    return {idKey: id, brandKey: brand};
  }
}

class EditEngineCapacityBody {
  final String id;
  final String capacity;

  static const String idKey = 'id';
  static const String capacityKey = 'capacity';

  EditEngineCapacityBody({required this.id, required this.capacity});

  Map<String, dynamic> toMap() {
    return {idKey: id, capacityKey: capacity};
  }
}

class DeleteSiteBody {
  final List<String> ids;

  static const String idsKey = 'ids';

  DeleteSiteBody({required this.ids});

  Map<String, dynamic> toMap() {
    return {idsKey: ids};
  }
}

class DeleteGeneratorBody {
  final List<String> ids;

  static const String idsKey = 'ids';

  DeleteGeneratorBody({required this.ids});

  Map<String, dynamic> toMap() {
    return {idsKey: ids};
  }
}

class DeleteEngineBody {
  final List<String> ids;

  static const String idsKey = 'ids';

  DeleteEngineBody({required this.ids});

  Map<String, dynamic> toMap() {
    return {idsKey: ids};
  }
}

class DeletePartBody {
  final List<String> ids;

  static const String idsKey = 'ids';

  DeletePartBody({required this.ids});

  Map<String, dynamic> toMap() {
    return {idsKey: ids};
  }
}

class DeleteGeneratorBrandBody {
  final List<String> ids;

  static const String idsKey = 'ids';

  DeleteGeneratorBrandBody({required this.ids});

  Map<String, dynamic> toMap() {
    return {idsKey: ids};
  }
}

class DeleteEngineBrandBody {
  final List<String> ids;

  static const String idsKey = 'ids';

  DeleteEngineBrandBody({required this.ids});

  Map<String, dynamic> toMap() {
    return {idsKey: ids};
  }
}

class DeleteEngineCapacityBody {
  final List<String> ids;

  static const String idsKey = 'ids';

  DeleteEngineCapacityBody({required this.ids});

  Map<String, dynamic> toMap() {
    return {idsKey: ids};
  }
}

// class AddReportBody {
//   static const String generatorIdKey = 'generator_id';
//   static const String visitTypeKey = 'visit_type';
//   static const String reportNumberKey = 'report_number';
//   static const String visitDateKey = 'visit_date';
//   static const String visitTimeKey = 'visit_time';
//   static const String oilPressureKey = 'oil_pressure';
//   static const String temperatureKey = 'temperature';
//   static const String batterVoltKey = 'batter_volt';
//   static const String oilQuantityKey = 'oil_quantity';
//   static const String burnedOilQuantityKey = 'burned_oil_quantity';
//   static const String frequencyKey = 'frequency';
//   static const String meterKey = 'meter';
//   static const String lastMeterKey = 'last_meter';
//   static const String atsStatusKey = 'ats_status';
//   static const String lastVisitDateKey = 'last_visit_date';
//   static const String voltL1Key = 'volt_l1';
//   static const String voltL2Key = 'volt_l2';
//   static const String voltL3Key = 'volt_l3';
//   static const String loadL1Key = 'load_l1';
//   static const String loadL2Key = 'load_l2';
//   static const String loadL3Key = 'load_l3';
//   static const String visitResonsKey = 'visit_resons';
//   static const String technicianNotesKey = 'technician_notes';
//   static const String technicalStatusKey = 'technical_status';
//   static const String completedWorksKey = 'completed_works';
//   static const String visitLocationKey = 'visit_location';
//   static const String partsKey = 'parts';

//   final int generatorId;
//   final String visitType;
//   final String reportNumber;
//   final DateTime visitDate;
//   final String visitTime;
//   final double oilPressure;
//   final double temperature;
//   final double batterVolt;
//   final double oilQuantity;
//   final double burnedOilQuantity;
//   final double frequency;
//   final double meter;
//   final double lastMeter;
//   final String atsStatus;
//   final DateTime lastVisitDate;
//   final double voltL1;
//   final double voltL2;
//   final double voltL3;
//   final double loadL1;
//   final double loadL2;
//   final double loadL3;
//   final String visitResons;
//   final List<String> technicianNotes;
//   final String technicalStatus;
//   final List<String> completedWorks;
//   final String visitLocation;
//   final List<AddReportPartBody> parts;

//   AddReportBody({
//     required this.generatorId,
//     required this.visitType,
//     required this.reportNumber,
//     required this.visitDate,
//     required this.visitTime,
//     required this.oilPressure,
//     required this.temperature,
//     required this.batterVolt,
//     required this.oilQuantity,
//     required this.burnedOilQuantity,
//     required this.frequency,
//     required this.meter,
//     required this.lastMeter,
//     required this.atsStatus,
//     required this.lastVisitDate,
//     required this.voltL1,
//     required this.voltL2,
//     required this.voltL3,
//     required this.loadL1,
//     required this.loadL2,
//     required this.loadL3,
//     required this.visitResons,
//     required this.technicianNotes,
//     required this.technicalStatus,
//     required this.completedWorks,
//     required this.visitLocation,
//     required this.parts,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       generatorIdKey: generatorId,
//       visitTypeKey: visitType,
//       reportNumberKey: reportNumber,
//       visitDateKey: visitDate.toIso8601String(),
//       visitTimeKey: visitTime,
//       oilPressureKey: oilPressure,
//       temperatureKey: temperature,
//       batterVoltKey: batterVolt,
//       oilQuantityKey: oilQuantity,
//       burnedOilQuantityKey: burnedOilQuantity,
//       frequencyKey: frequency,
//       meterKey: meter,
//       lastMeterKey: lastMeter,
//       atsStatusKey: atsStatus,
//       lastVisitDateKey: lastVisitDate.toIso8601String(),
//       voltL1Key: voltL1,
//       voltL2Key: voltL2,
//       voltL3Key: voltL3,
//       loadL1Key: loadL1,
//       loadL2Key: loadL2,
//       loadL3Key: loadL3,
//       visitResonsKey: visitResons,
//       technicianNotesKey: technicianNotes,
//       technicalStatusKey: technicalStatus,
//       completedWorksKey: completedWorks,
//       visitLocationKey: visitLocation,
//       partsKey: parts.map((e) => e.toMap()).toList(),
//     };
//   }
// }

// class AddReportPartBody {
//   final int id;
//   final String note;
//   final String isFaulty;
//   final String lastReplacementDate;
//   final String quantity;
//   final String lastReplacementMeter;

//   static const String idKey = 'id';
//   static const String nameKey = 'name';
//   static const String quantityKey = 'quantity';
//   static const String codeKey = 'code';
//   static const String noteKey = 'note';
//   static const String isFaultyKey = 'is_faulty';
//   static const String lastReplacementDateKey = 'last_replacement_date';
//   static const String lastReplacementMeterKey = 'last_replacement_meter';

//   AddReportPartBody({
//     required this.id,
//     required this.note,
//     required this.isFaulty,
//     required this.lastReplacementDate,
//     required this.lastReplacementMeter,
//     required this.quantity,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       idKey: id,
//       quantityKey: quantity,
//       noteKey: note,
//       isFaultyKey: isFaulty,
//       lastReplacementDateKey: lastReplacementDate,
//       lastReplacementMeterKey: lastReplacementMeter,
//     };
//   }
// }

// class EditReportBody {
//   static const String idKey = 'id';
//   static const String generatorIdKey = 'generator_id';
//   static const String visitTypeKey = 'visit_type';
//   static const String reportNumberKey = 'report_number';
//   static const String visitDateKey = 'visit_date';
//   static const String visitTimeKey = 'visit_time';
//   static const String oilPressureKey = 'oil_pressure';
//   static const String temperatureKey = 'temperature';
//   static const String batterVoltKey = 'batter_volt';
//   static const String oilQuantityKey = 'oil_quantity';
//   static const String burnedOilQuantityKey = 'burned_oil_quantity';
//   static const String frequencyKey = 'frequency';
//   static const String meterKey = 'meter';
//   static const String lastMeterKey = 'last_meter';
//   static const String atsStatusKey = 'ats_status';
//   static const String lastVisitDateKey = 'last_visit_date';
//   static const String voltL1Key = 'volt_l1';
//   static const String voltL2Key = 'volt_l2';
//   static const String voltL3Key = 'volt_l3';
//   static const String loadL1Key = 'load_l1';
//   static const String loadL2Key = 'load_l2';
//   static const String loadL3Key = 'load_l3';
//   static const String visitResonsKey = 'visit_resons';
//   static const String technicianNotesKey = 'technician_notes';
//   static const String technicalStatusKey = 'technical_status';
//   static const String completedWorksKey = 'completed_works';
//   static const String visitLocationKey = 'visit_location';
//   static const String partsKey = 'parts';

//   final int id;
//   final int generatorId;
//   final String visitType;
//   final String reportNumber;
//   final DateTime visitDate;
//   final String visitTime;
//   final double oilPressure;
//   final double temperature;
//   final double batterVolt;
//   final double oilQuantity;
//   final double burnedOilQuantity;
//   final double frequency;
//   final double meter;
//   final double lastMeter;
//   final String atsStatus;
//   final DateTime lastVisitDate;
//   final double voltL1;
//   final double voltL2;
//   final double voltL3;
//   final double loadL1;
//   final double loadL2;
//   final double loadL3;
//   final String visitResons;
//   final List<String> technicianNotes;
//   final String technicalStatus;
//   final List<String> completedWorks;
//   final String visitLocation;
//   final List<AddReportPartBody> parts;

//   EditReportBody({
//     required this.id,
//     required this.generatorId,
//     required this.visitType,
//     required this.reportNumber,
//     required this.visitDate,
//     required this.visitTime,
//     required this.oilPressure,
//     required this.temperature,
//     required this.batterVolt,
//     required this.oilQuantity,
//     required this.burnedOilQuantity,
//     required this.frequency,
//     required this.meter,
//     required this.lastMeter,
//     required this.atsStatus,
//     required this.lastVisitDate,
//     required this.voltL1,
//     required this.voltL2,
//     required this.voltL3,
//     required this.loadL1,
//     required this.loadL2,
//     required this.loadL3,
//     required this.visitResons,
//     required this.technicianNotes,
//     required this.technicalStatus,
//     required this.completedWorks,
//     required this.visitLocation,
//     required this.parts,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       idKey: id,
//       generatorIdKey: generatorId,
//       visitTypeKey: visitType,
//       reportNumberKey: reportNumber,
//       visitDateKey: visitDate.toIso8601String(),
//       visitTimeKey: visitTime,
//       oilPressureKey: oilPressure,
//       temperatureKey: temperature,
//       batterVoltKey: batterVolt,
//       oilQuantityKey: oilQuantity,
//       burnedOilQuantityKey: burnedOilQuantity,
//       frequencyKey: frequency,
//       meterKey: meter,
//       lastMeterKey: lastMeter,
//       atsStatusKey: atsStatus,
//       lastVisitDateKey: lastVisitDate.toIso8601String(),
//       voltL1Key: voltL1,
//       voltL2Key: voltL2,
//       voltL3Key: voltL3,
//       loadL1Key: loadL1,
//       loadL2Key: loadL2,
//       loadL3Key: loadL3,
//       visitResonsKey: visitResons,
//       technicianNotesKey: technicianNotes,
//       technicalStatusKey: technicalStatus,
//       completedWorksKey: completedWorks,
//       visitLocationKey: visitLocation,
//       partsKey: parts.map((e) => e.toMap()).toList(),
//     };
//   }
// }

// class DeleteReportBody {
//   final List<int> ids;

//   static const String idsKey = 'ids';

//   DeleteReportBody({required this.ids});

//   Map<String, dynamic> toMap() {
//     return {idsKey: ids};
//   }
// }

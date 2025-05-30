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

  static const String nameKey = 'name';
  static const String codeKey = 'code';

  AddSiteBody({required this.name, required this.code});

  Map<String, dynamic> toMap() {
    return {nameKey: name, codeKey: code};
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

  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String codeKey = 'code';

  EditSiteBody({required this.id, required this.name, required this.code});

  Map<String, dynamic> toMap() {
    return {idKey: id, nameKey: name, codeKey: code};
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

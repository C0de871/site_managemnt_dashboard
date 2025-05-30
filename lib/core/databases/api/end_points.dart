class EndPoints {
  static const String baseUrl = "https://api.example.com";

  //!get
  static const String getGenerators = "$baseUrl/getGenerators";
  static const String getReports = "$baseUrl/getReports";
  static const String getReportDetailsById = "$baseUrl/getReportDetailsById";
  static const String getSites = "$baseUrl/getSites";
  static const String getGeneratorsBrands = "$baseUrl/getGeneratorsBrands";
  static const String getParts = "$baseUrl/getParts";
  static const String getEnginesBrands = "$baseUrl/getEnginesBrands";
  static const String getEnginesCapacities = "$baseUrl/getEnginesCapacities";
  static const String getEngines = "$baseUrl/getEngines";

  static const String addSite = "$baseUrl/addSite";
  static const String createEngine = "$baseUrl/createEngine";
  static const String addPart = "$baseUrl/addPart";
  static const String addEngineBrand = "$baseUrl/addEngineBrand";
  static const String addEngineCapacity = "$baseUrl/addEngineCapacity";
  static const String addGeneratorBrand = "$baseUrl/addGeneratorBrand";
  static const String createGenerator = "$baseUrl/createGenerator";

  //!edits
  static const String editSite = "$baseUrl/editSite";
  static const String editGenerator = "$baseUrl/editGenerator";
  static const String editEngine = "$baseUrl/editEngine";
  static const String editPart = "$baseUrl/editPart";
  static const String editEngineBrand = "$baseUrl/editEngineBrand";
  static const String editEngineCapacity = "$baseUrl/editEngineCapacity";
  static const String editGeneratorBrand = "$baseUrl/editGeneratorBrand";

  //!delete
  static const String deleteSite = "$baseUrl/deleteSite";
  static const String deleteGenerator = "$baseUrl/deleteGenerator";
  static const String deleteEngine = "$baseUrl/deleteEngine";
  static const String deletePart = "$baseUrl/deletePart";
  static const String deleteEngineBrand = "$baseUrl/deleteEngineBrand";
  static const String deleteEngineCapacity = "$baseUrl/deleteEngineCapacity";
  static const String deleteGeneratorBrand = "$baseUrl/deleteGeneratorBrand";
}

class ApiKey {
  static const String message = "message";
  static const String statusCode = "status";
  static const String data = "data";
}

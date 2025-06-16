class EndPoints {
  static const String baseUrl = "http://127.0.0.1:8000/api";

  //!auth
  static const String login = "$baseUrl/login";
  static const String logout = "$baseUrl/logout";

  //!get
  static const String getGenerators = "$baseUrl/generators";
  static const String getReports = "$baseUrl/reports";
  static const String getReportDetailsById = "$baseUrl/getReportDetailsById";
  static const String getSites = "$baseUrl/mtn-sites";
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

  static const String addReport = "$baseUrl/addReport";
  static const String editReport = "$baseUrl/editReport";
  static const String deleteReport = "$baseUrl/deleteReport";

  static const String getGeneratorsBySiteID = "$baseUrl/mtn-sites/generators";
}

class ApiKey {
  static const String message = "message";
  static const String statusCode = "status";
  static const String data = "data";

  static const String totalItems = "total";

  static const String currentItemsCount = "count";

  static const String currentPage = "current_page";
}

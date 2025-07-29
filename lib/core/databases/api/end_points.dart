class EndPoints {
  static const String baseUrl = "http://127.0.0.1:8000/api";

  //!auth
  static const String login = "$baseUrl/login";
  static const String logout = "$baseUrl/logout";

  //!get
  static const String getGenerators = "$baseUrl/generators/search";
  static const String getReports = "$baseUrl/reports";
  static const String getReportDetailsById = "$baseUrl/reports";
  static const String getSites = "$baseUrl/mtn-sites";
  static String searchSitesByCode = "/mtn-sites/search";
  static const String getGeneratorsBrands = "$baseUrl/brands?type=generator";
  static const String getParts = "$baseUrl/parts/search";
  static const String getEnginesBrands = "$baseUrl/brands?type=engine";
  static const String getEnginesCapacities = "$baseUrl/capacities";
  static const String getEngines = "$baseUrl/engines";

  //!add
  static const String addSite = "$baseUrl/mtn-sites";
  static const String createEngine = "$baseUrl/engines";
  static const String addPart = "$baseUrl/parts";
  static const String addEngineBrand = "$baseUrl/brands?type=engine";
  static const String addEngineCapacity = "$baseUrl/capacities";
  static const String addGeneratorBrand = "$baseUrl/brands?type=generator";
  static const String createGenerator = "$baseUrl/generators";

  //!edits
  static const String editSite = "$baseUrl/mtn-sites";
  static const String editGenerator = "$baseUrl/generators";
  static const String editEngine = "$baseUrl/engines";
  static const String editPart = "$baseUrl/parts";
  static const String editEngineBrand = "$baseUrl/brands";
  static const String editEngineCapacity = "$baseUrl/capacities";
  static const String editGeneratorBrand = "$baseUrl/brands";

  //!delete
  static const String deleteSite = "$baseUrl/mtn-sites";
  static const String deleteGenerator = "$baseUrl/generators";
  static const String deleteEngine = "$baseUrl/engines";
  static const String deletePart = "$baseUrl/parts";
  static const String deleteEngineBrand = "$baseUrl/brands";
  static const String deleteEngineCapacity = "$baseUrl/capacities";
  static const String deleteGeneratorBrand = "$baseUrl/brands";

  static const String addReport = "$baseUrl/addReport";
  static const String editReport = "$baseUrl/editReport";
  static const String deleteReport = "$baseUrl/deleteReport";

  static const String getGeneratorsBySiteID = "$baseUrl/mtn-sites/generators";

  //!export reports
  static String exportReports = "$baseUrl/reports/export";
}

class ApiKey {
  static const String message = "message";
  static const String statusCode = "status";
  static const String data = "data";

  static const String totalItems = "total";

  static const String currentItemsCount = "count";

  static const String currentPage = "current_page";
}

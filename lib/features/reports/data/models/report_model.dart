import '../../../sites/data/models/sites_model.dart';
import '../../domain/entities/report_entity.dart';

class ReportModel extends ReportEntity {
  static const String idKey = 'id';
  static const String siteKey = 'site';
  static const String typeKey = 'type';
  static const String dateKey = 'date';

  const ReportModel({
    required super.id,
    required super.site,
    required super.visitType,
    required super.visitDate,
  });

  // Factory method to create a ReportModel from a JSON Map
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json[idKey] as int,
      site: SitesModel.fromJson(json[siteKey] as Map<String, dynamic>),
      visitType: _parseReportType(json[typeKey] as String),
      visitDate: DateTime.parse(json[dateKey] as String),
    );
  }

  // Convert ReportModel to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      idKey: id,
      siteKey: site,
      typeKey: visitType.toString().split('.').last,
      dateKey: visitDate.toIso8601String(),
    };
  }

  // Helper method to parse report type from string
  static VisitType _parseReportType(String type) {
    switch (type) {
      case ReportEntity.routine:
        return VisitType.routine;
      case ReportEntity.emergency:
        return VisitType.emergency;
      case ReportEntity.umrah:
        return VisitType.umrah;
      default:
        return VisitType.routine;
    }
  }
}

import '../../../sites/data/models/sites_model.dart';
import '../../domain/entities/report_entity.dart';

class ReportModel extends ReportEntity {
  static const String idKey = 'id';
  static const String siteKey = 'mtn_site';
  static const String typeKey = 'visit_type';
  static const String dateKey = 'visit_date';
  static const String usernameKey = 'username';

  const ReportModel({
    required super.id,
    required super.site,
    required super.visitType,
    required super.visitDate,
    required super.username,
  });

  // Factory method to create a ReportModel from a JSON Map
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json[idKey] as int,
      site: SitesModel.fromJson(json[siteKey] as Map<String, dynamic>),
      visitType: (json[typeKey] as String).visitType,
      visitDate: DateTime.parse(json[dateKey] as String),
      username: json[usernameKey] as String?,
    );
  }

  // Convert ReportModel to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      idKey: id,
      siteKey: (site as SitesModel).toJson(),
      typeKey: visitType.toString(),
      dateKey: visitDate.toIso8601String(),
      usernameKey: username,
    };
  }
}

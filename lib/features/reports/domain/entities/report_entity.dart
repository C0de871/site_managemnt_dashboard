import 'package:equatable/equatable.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/entities/sites_entity.dart';

enum VisitType {
  routine, // زيارة دورية
  emergency, // طارئة
  umrah, // عمرة
}

extension ReportTypeExtension on VisitType {
  String get arabicName {
    switch (this) {
      case VisitType.routine:
        return 'زيارة دورية';
      case VisitType.emergency:
        return 'طارئة';
      case VisitType.umrah:
        return 'عمرة';
    }
  }
}

class ReportEntity extends Equatable {
  final int id;
  final SitesEntity site;
  final VisitType visitType;
  final DateTime visitDate;

  static const routine = 'routine';
  static const emergency = 'emergency';
  static const umrah = 'umrah';

  const ReportEntity({
    required this.id,
    required this.site,
    required this.visitType,
    required this.visitDate,
  });

  @override
  List<Object?> get props => [id, site, visitType, visitDate];

  // For convenience in the app
  String get formattedDate {
    return '${visitDate.day}/${visitDate.month}/${visitDate.year}';
  }

  // Create a copy of this report with updated fields
  ReportEntity copyWith({
    int? id,
    SitesEntity? site,
    VisitType? visitType,
    DateTime? visitDate,
  }) {
    return ReportEntity(
      id: id ?? this.id,
      site: site ?? this.site,
      visitType: visitType ?? this.visitType,
      visitDate: visitDate ?? this.visitDate,
    );
  }
}

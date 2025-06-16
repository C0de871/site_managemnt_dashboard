import 'package:equatable/equatable.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/entities/sites_entity.dart';

import '../../../../core/utils/constants/constant.dart';

enum VisitType {
  routine, // زيارة دورية
  emergency, // طارئة
  overhaul, // عمرة
}

extension ReportTypeExtension on VisitType {
  String get arabicName {
    switch (this) {
      case VisitType.routine:
        return 'زيارة دورية';
      case VisitType.emergency:
        return 'طارئة';
      case VisitType.overhaul:
        return 'عمرة';
    }
  }
}

extension GetVisitType on String {
  VisitType get visitType {
    switch (this) {
      case Constant.routine:
        return VisitType.routine;
      case Constant.emergency:
        return VisitType.emergency;
      case Constant.umrah:
        return VisitType.overhaul;
      default:
        return VisitType.routine;
    }
  }
}

class ReportEntity extends Equatable {
  final int id;
  final SiteEntity site;
  final VisitType visitType;
  final DateTime visitDate;

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
    SiteEntity? site,
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

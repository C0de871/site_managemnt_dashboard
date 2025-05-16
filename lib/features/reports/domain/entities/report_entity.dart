import 'package:equatable/equatable.dart';

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
  final String code;
  final String name;
  final VisitType visitType;
  final DateTime visitDate;

  static const routine = 'routine';
  static const emergency = 'emergency';
  static const umrah = 'umrah';

  const ReportEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.visitType,
    required this.visitDate,
  });

  @override
  List<Object?> get props => [id, code, name, visitType, visitDate];

  // For convenience in the app
  String get formattedDate {
    return '${visitDate.day}/${visitDate.month}/${visitDate.year}';
  }

  // Create a copy of this report with updated fields
  ReportEntity copyWith({
    int? id,
    String? code,
    String? name,
    VisitType? type,
    DateTime? date,
  }) {
    return ReportEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      visitType: type ?? this.visitType,
      visitDate: date ?? this.visitDate,
    );
  }
}

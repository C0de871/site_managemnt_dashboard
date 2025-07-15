// domain/entities/technician_note_entity.dart
import 'package:equatable/equatable.dart';

class TechnicianNoteEntity extends Equatable {
  final int id;
  final String note;

  const TechnicianNoteEntity({
    required this.id,
    required this.note,
  });

  @override
  List<Object?> get props => [id, note];
}
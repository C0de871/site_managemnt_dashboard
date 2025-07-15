// data/models/technician_note_model.dart
import '../../domain/entities/technician_note_entity.dart';

class TechnicianNoteModel extends TechnicianNoteEntity {
  const TechnicianNoteModel({required super.id, required super.note});

  static const String idKey = 'id';
  static const String noteKey = 'note';

  factory TechnicianNoteModel.fromJson(Map<String, dynamic> json) {
    return TechnicianNoteModel(id: json[idKey], note: json[noteKey]);
  }

  Map<String, dynamic> toJson() => {idKey: id, noteKey: note};
}

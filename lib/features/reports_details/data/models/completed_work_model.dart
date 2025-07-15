// data/models/completed_work_model.dart
import '../../domain/entities/completed_work_entity.dart';

class CompletedWorkModel extends CompletedWorkEntity {
  const CompletedWorkModel({required super.id, required super.description});

  static const String idKey = 'id';
  static const String descriptionKey = 'description';

  factory CompletedWorkModel.fromJson(Map<String, dynamic> json) {
    return CompletedWorkModel(
      id: json[idKey],
      description: json[descriptionKey],
    );
  }

  Map<String, dynamic> toJson() => {idKey: id, descriptionKey: description};
}

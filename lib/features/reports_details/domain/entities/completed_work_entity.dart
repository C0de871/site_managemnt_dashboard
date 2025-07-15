// domain/entities/completed_work_entity.dart
import 'package:equatable/equatable.dart';

class CompletedWorkEntity extends Equatable {
  final int id;
  final String description;

  const CompletedWorkEntity({required this.id, required this.description});

  @override
  List<Object?> get props => [id, description];
}

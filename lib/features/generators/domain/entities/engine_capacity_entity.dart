import 'package:equatable/equatable.dart';

class EngineCapacityEntity extends Equatable {
  final int id;
  final int capacity;

  const EngineCapacityEntity({required this.id, required this.capacity});

  @override
  List<Object?> get props => [id, capacity];

  EngineCapacityEntity copyWith({int? id, int? capacity}) {
    return EngineCapacityEntity(
      id: id ?? this.id,
      capacity: capacity ?? this.capacity,
    );
  }
}

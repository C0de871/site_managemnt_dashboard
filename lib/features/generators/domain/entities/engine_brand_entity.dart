import 'package:equatable/equatable.dart';

class EngineBrandEntity extends Equatable {
  final int id;
  final String brand;

  const EngineBrandEntity({required this.id, required this.brand});

  @override
  List<Object?> get props => [id, brand];

  EngineBrandEntity copyWith({int? id, String? brand}) {
    return EngineBrandEntity(id: id ?? this.id, brand: brand ?? this.brand);
  }
}

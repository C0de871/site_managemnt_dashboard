import 'package:equatable/equatable.dart';

class GeneratorBrandEntity extends Equatable {
  final int id;
  final String brand;

  const GeneratorBrandEntity({required this.id, required this.brand});

  @override
  List<Object?> get props => [id, brand];

  GeneratorBrandEntity copyWith({int? id, String? brand}) {
    return GeneratorBrandEntity(id: id ?? this.id, brand: brand ?? this.brand);
  }
}

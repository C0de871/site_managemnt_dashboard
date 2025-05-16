import 'package:equatable/equatable.dart';

class SitesEntity extends Equatable {
  final int id;
  final String name;
  final String code;

  const SitesEntity({required this.id, required this.name, required this.code});

  @override
  List<Object?> get props => [id, name, code];

  SitesEntity copyWith({int? id, String? name, String? code}) {
    return SitesEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }
}

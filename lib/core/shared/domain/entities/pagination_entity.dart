import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class PaginationEntity extends Equatable {
  final int? currentPage;
  final int? totalItemsCount;
  final int? currentItemsCount;
  // final int? totalPages;
  // final bool? hasMorePage;

  const PaginationEntity({
    this.currentPage,
    this.totalItemsCount,
    this.currentItemsCount,
    // this.totalPages,
    // this.hasMorePage,
  });

  @override
  List<Object?> get props => [
    currentPage,
    totalItemsCount,
    currentItemsCount,
    // totalPages,
    // hasMorePage,
  ];

  PaginationEntity copyWith({
    int? currentPage,
    int? totalItemsCount,
    int? currentItemsCount,
    int? totalPages,
    bool? hasMorePage,
  }) {
    return PaginationEntity(
      currentPage: currentPage ?? this.currentPage,
      // hasMorePage: hasMorePage ?? this.hasMorePage,
      totalItemsCount: totalItemsCount ?? this.totalItemsCount,
      currentItemsCount: currentItemsCount ?? this.currentItemsCount,
      // totalPages: totalPages ?? this.totalPages,
    );
  }
}

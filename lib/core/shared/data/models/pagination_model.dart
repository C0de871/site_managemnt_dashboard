import 'dart:developer';

import 'package:flutter/widgets.dart';

import '../../../databases/api/end_points.dart';
import '../../domain/entities/pagination_entity.dart';

@immutable
class PaginationModel extends PaginationEntity {
  const PaginationModel({
    super.currentPage,
    super.currentItemsCount,
    super.totalItemsCount,
    // super.totalPages,
    // super.hasMorePage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> data) {
    log(data.toString());
    return PaginationModel(
      currentPage: data[ApiKey.currentPage] as int?,
      currentItemsCount: data[ApiKey.currentItemsCount] as int?,
      totalItemsCount: data[ApiKey.totalItems] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
    ApiKey.currentPage: currentPage,
    ApiKey.totalItems: totalItemsCount,
    ApiKey.currentItemsCount: currentItemsCount,
  };
}

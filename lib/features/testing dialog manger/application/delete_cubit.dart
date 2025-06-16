// ignore_for_file: dead_code

import 'package:flutter_bloc/flutter_bloc.dart';

enum DeleteStatus { initial, loading, success, failure }

class DeleteCubit extends Cubit<DeleteStatus> {
  DeleteCubit() : super(DeleteStatus.initial);

  Future<void> deleteItem() async {
    emit(DeleteStatus.loading);
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    final success = false; // Change to false to simulate failure
    if (success) {
      emit(DeleteStatus.success);
    } else {
      emit(DeleteStatus.failure);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/delete_cubit.dart';
import '../../reports/presentation/dialogs/report_dialog_service.dart';

class MyScreen extends StatelessWidget {
  final dialogService = ReportDialogService();

  MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeleteCubit(),
      child: Builder(
        builder: (context) {
          return BlocListener<DeleteCubit, DeleteStatus>(
            listener: (context, state) {
              if (state == DeleteStatus.loading) {
                dialogService.showLoadingDialog();
              } else if (state == DeleteStatus.success) {
                dialogService.hideDialog();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Deleted successfully')),
                );
              } else if (state == DeleteStatus.failure) {
                dialogService.showErrorDialog('Failed to delete item.');
              }
            },
            child: Scaffold(
              appBar: AppBar(title: const Text('Delete Example')),
              body: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final confirmed = await dialogService
                        .showConfirmationDialog(
                          title: 'Delete Item',
                          content: 'Are you sure you want to delete this item?',
                        );

                    if (confirmed == true) {
                      if (context.mounted) {
                        context.read<DeleteCubit>().deleteItem();
                      }
                    }
                  },
                  child: const Text('Delete'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

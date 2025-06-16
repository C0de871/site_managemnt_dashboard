import 'dart:ui';

import 'package:flutter/material.dart';

import '../../shared/dialog/confirm_delete_dialog.dart';

class DialogLauncher {
  static void showConfirmDeleteDialog(
    BuildContext context, {
    required String title,
    required String content,
    required Future<void> Function() onConfirm,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => ConfirmDeleteDialog(
            title: title,
            content: content,
            onConfirm: onConfirm,
          ),
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder:
          (context) => PopScope(
            canPop: false, // Prevents back button dismissal
            child: AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text('Loading...'),
                ],
              ),
            ),
          ),
    );
  }

  // To dismiss the dialog later
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}

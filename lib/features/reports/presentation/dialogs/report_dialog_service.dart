import 'package:flutter/material.dart';

class ReportDialogService {
  static final ReportDialogService _instance = ReportDialogService._internal();
  factory ReportDialogService() => _instance;

  bool isDialogOpen = false;

  ReportDialogService._internal();

  late GlobalKey<NavigatorState> _dialogNavigationKey;

  void registerNavigationKey(GlobalKey<NavigatorState> key) {
    _dialogNavigationKey = key;
  }

  Future<bool?> showConfirmationDialog({
    required String title,
    required String content,
  }) {
    hideDialog();

    isDialogOpen = true;
    return showDialog<bool>(
      context: _dialogNavigationKey.currentContext!,
      builder:
          (_) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  hideDialog(false);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => hideDialog(true),
                child: const Text('Delete'),
              ),
            ],
          ),
    ).whenComplete(() => isDialogOpen = false);
  }

  Future<void> showLoadingDialog() {
    hideDialog();
    isDialogOpen = true;
    return showDialog(
      context: _dialogNavigationKey.currentContext!,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Loading...'),
              ],
            ),
          ),
    ).whenComplete(() => isDialogOpen = false);
  }

  Future<void> showErrorDialog(String message) {
    hideDialog();
    isDialogOpen = true;
    return showDialog(
      context: _dialogNavigationKey.currentContext!,
      builder:
          (_) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed:
                    () => Navigator.pop(_dialogNavigationKey.currentContext!),
                child: const Text('OK'),
              ),
            ],
          ),
    ).whenComplete(() => isDialogOpen = false);
  }

  void hideDialog<T>([T? result]) {
    if (isDialogOpen) {
      isDialogOpen = false;
      Navigator.pop(_dialogNavigationKey.currentContext!, result);
    }
  }
}

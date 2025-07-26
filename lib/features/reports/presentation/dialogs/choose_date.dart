import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExportDateRangeDialog extends StatefulWidget {
  final Function(String startDate, String endDate) onExport;

  const ExportDateRangeDialog({super.key, required this.onExport});

  @override
  State<ExportDateRangeDialog> createState() => _ExportDateRangeDialogState();
}

class _ExportDateRangeDialogState extends State<ExportDateRangeDialog>
    with SingleTickerProviderStateMixin {
  DateTime? startDate;
  DateTime? endDate;
  String? errorMessage;
  bool isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void _validateDates() {
    setState(() {
      errorMessage = null;
    });

    if (startDate == null || endDate == null) {
      setState(() {
        errorMessage = 'Please select both start and end dates';
      });
      return;
    }

    if (startDate!.isAfter(endDate!)) {
      setState(() {
        errorMessage = 'Start date cannot be after end date';
      });
      return;
    }

    final now = DateTime.now();
    if (startDate!.isAfter(now) || endDate!.isAfter(now)) {
      setState(() {
        errorMessage = 'Dates cannot be in the future';
      });
      return;
    }

    final daysDifference = endDate!.difference(startDate!).inDays;
    if (daysDifference > 365) {
      setState(() {
        errorMessage = 'Date range cannot exceed 365 days';
      });
      return;
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStartDate
              ? (startDate ?? DateTime.now().subtract(const Duration(days: 30)))
              : (endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
        errorMessage = null;
      });
    }
  }

  Future<void> _handleExport() async {
    _validateDates();

    if (errorMessage != null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final formattedStartDate = _formatDate(startDate!);
      final formattedEndDate = _formatDate(endDate!);

      await widget.onExport(formattedStartDate, formattedEndDate);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Export initiated for $formattedStartDate to $formattedEndDate',
                ),
              ],
            ),
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      setState(() {
        errorMessage = 'Export failed. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: Container(
          width: 480,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey[50]!],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.file_download_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Export Reports',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        Text(
                          'Select date range for your export',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Color(0xFF6B7280)),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Date Selection Cards
              Row(
                children: [
                  Expanded(
                    child: _buildDateCard(
                      context,
                      'Start Date',
                      startDate,
                      Icons.calendar_today_outlined,
                      () => _selectDate(context, true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDateCard(
                      context,
                      'End Date',
                      endDate,
                      Icons.event_outlined,
                      () => _selectDate(context, false),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Error Message
              if (errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red[700],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          errorMessage!,
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              if (errorMessage != null) const SizedBox(height: 24),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed:
                        isLoading ? null : () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: isLoading ? null : _handleExport,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child:
                        isLoading
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                            : const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.download, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'Export',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateCard(
    BuildContext context,
    String label,
    DateTime? date,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              date != null
                  ? Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.05)
                  : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                date != null
                    ? Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.3)
                    : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color:
                      date != null
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[600],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              date != null ? _formatDate(date) : 'Select date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:
                    date != null ? const Color(0xFF1F2937) : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

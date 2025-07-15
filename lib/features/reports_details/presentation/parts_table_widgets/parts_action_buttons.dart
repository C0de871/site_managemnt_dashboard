// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../cubit/report_details_cubit.dart';

// class PartsActionButtons extends StatelessWidget {
//   const PartsActionButtons({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return BlocBuilder<ReportDetailsCubit, ReportDetailsState>(
//       builder: (context, state) {
//         if (state.reportDetailsStatus.isLoaded) {
//           return Row(
//             children: [
//               // Delete Button
//               ElevatedButton.icon(
//                 onPressed:
//                     hasSelectedParts
//                         ? () {
//                           context.read<PartsCubit>().deleteSelectedParts();
//                         }
//                         : null,
//                 icon: const Icon(Icons.delete),
//                 label: Text('Delete (${state.selectedPartIds.length})'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: colorScheme.errorContainer,
//                   foregroundColor: colorScheme.onErrorContainer,
//                   disabledBackgroundColor: colorScheme.errorContainer
//                       .withValues(alpha: 0.3),
//                   disabledForegroundColor: colorScheme.onErrorContainer
//                       .withValues(alpha: 0.5),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 10,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }

//         return const SizedBox.shrink();
//       },
//     );
//   }
// }

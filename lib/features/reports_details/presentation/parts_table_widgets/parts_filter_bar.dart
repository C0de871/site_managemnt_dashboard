// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../cubit/parts_cubit.dart';
// import 'parts_action_buttons.dart';

// class PartsFilterBar extends StatelessWidget {
//   const PartsFilterBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return Container(
//       // padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         border: Border(
//           bottom: BorderSide(
//             color: colorScheme.outlineVariant.withValues(alpha: 0.5),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           BlocBuilder<PartsCubit, PartsState>(
//             builder: (context, state) {
//               if (state.partsStatus.isLoaded) {
//                 return const PartsActionButtons();
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

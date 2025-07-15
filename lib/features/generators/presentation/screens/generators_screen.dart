import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/core/shared/widgets/failed_snack_bar.dart';
import 'package:site_managemnt_dashboard/core/shared/widgets/success_snack_bar.dart';
import '../../../reports/presentation/screens/widgets/screen_header.dart';
import '../cubit/generators_cubit.dart';
import '../widgets/generators_engines_content.dart';

class GeneratorsScreen extends StatelessWidget {
  const GeneratorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<GeneratorsEnginesCubit>();

    return BlocListener<GeneratorsEnginesCubit, GeneratorsEnginesState>(
      listenWhen: (old, current) => old.actionStatus != current.actionStatus,
      listener: (context, state) {
        if (state.actionStatus.isError) {
          //snackbar:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(FailedSnackBar(message: state.error));
        } else if (state.actionStatus.isLoaded) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SuccessSnackBar(message: "تمت العملية بنجاح"));
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screen Header
            ScreenHeader(
              title: 'Generators',
              subtitle: 'Manage your generators',
              icon: Icons.energy_savings_leaf_outlined,
            ),

            // Main Content
            Expanded(
              child:
                  BlocBuilder<GeneratorsEnginesCubit, GeneratorsEnginesState>(
                    builder: (context, state) {
                      return GeneratorsEnginesContent(
                        generators: state.generators,
                      );
                      // switch (state.generatorsStatus) {
                      //   case GeneratorsEnginesStatus.loading ||
                      //       GeneratorsEnginesStatus.initial:
                      //     return Center(
                      //       child: CircularProgressIndicator(
                      //         color: colorScheme.primary,
                      //       ),
                      //     );
                      //   case GeneratorsEnginesStatus.error:
                      //     return MyErrorWidget(
                      //       colorScheme: colorScheme,
                      //       message: state.error,
                      //       onPressed:
                      //           () =>
                      //               context
                      //                   .read<GeneratorsEnginesCubit>()
                      //                   .fetchGenerators(),
                      //       title: 'Error loading generators',
                      //     );
                      //   case GeneratorsEnginesStatus.loaded:
                      //     return GeneratorsEnginesContent(
                      //       generators: state.generators,
                      //     );
                      // }
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

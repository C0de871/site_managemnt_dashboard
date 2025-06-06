import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/my_error_widget.dart';
import '../../../reports/presentation/screens/widgets/screen_header.dart';
import '../cubit/parts_cubit.dart';
import '../widgets/parts_content.dart';

class PartsScreen extends StatelessWidget {
  const PartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Screen Header
          ScreenHeader(
            title: 'Parts',
            subtitle: 'Manage your parts',
            icon: Icons.energy_savings_leaf_outlined,
          ),

          // Main Content
          Expanded(
            child: BlocBuilder<PartsCubit, PartsState>(
              builder: (context, state) {
                switch (state.partsStatus) {
                  case PartsStatus.loading || PartsStatus.initial:
                    return Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                      ),
                    );
                  case PartsStatus.error:
                    return MyErrorWidget(
                      colorScheme: colorScheme,
                      message: state.error,
                      onPressed: () => context.read<PartsCubit>().fetchParts(),
                      title: 'Error loading parts',
                    );
                  case PartsStatus.loaded:
                    return PartsContent(parts: state.parts);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

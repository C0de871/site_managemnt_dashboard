import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/parts/presentation/cubit/parts_cubit.dart';
import 'package:site_managemnt_dashboard/features/parts/presentation/widgets/engine_data_table.dart';
import 'package:site_managemnt_dashboard/features/parts/presentation/widgets/engines_filter.dart';

class RightTable extends StatelessWidget {
  const RightTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartsCubit, PartsState>(
      builder: (context, state) {
        return state.currentPartEnginesId != -1
            ? Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EnginesFilterBar(),
                  Expanded(
                    child: EnginesDataTable(partId: state.currentPartEnginesId),
                  ),
                ],
              ),
            )
            : const SizedBox.shrink();
      },
    );
  }
}

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:site_managemnt_dashboard/features/generators/presentation/cubit/generators_cubit.dart';

import '../../../sites/domain/entities/sites_entity.dart';

class SitesDropList extends StatelessWidget {
  const SitesDropList({super.key, required this.onChanged});

  final void Function(SiteEntity?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GeneratorsEnginesCubit>();
    return DropdownSearch<SiteEntity>(
      decoratorProps: const DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: 'المواقع',
          hintText: 'اختر موقع',
        ),
      ),
      compareFn: (a, b) {
        return a == b;
      },
      itemAsString: (site) {
        return "${site.name} ${site.code} ";
      },
      // onChanged: (value) {
      //   if (value != null) {
      //     context.read<GeneratorsEnginesCubit>().loadSiteGenerators(value);
      //   }
      // },
      popupProps: PopupProps.menu(
        cacheItems: false,
        searchFieldProps: const TextFieldProps(
          decoration: InputDecoration(hint: Text("ادخل كود الموقع للبحث")),
        ),
        menuProps: const MenuProps(align: MenuAlign.topCenter),
        showSearchBox: true,
        disableFilter: true,

        searchDelay: const Duration(milliseconds: 500),
        infiniteScrollProps: InfiniteScrollProps(
          loadProps: const LoadProps(skip: 0, take: 20),
          loadingMoreBuilder:
              (context, index) => Container(
                padding: const EdgeInsets.all(16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 16),
                    Text('جاري تحميل المزيد'),
                  ],
                ),
              ),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'المواقع:',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        loadingBuilder: (context, message) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                Text(message),
              ],
            ),
          );
        },
        errorBuilder: (context, message, dyn) {
          return SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.error,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'حدث خطأ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dyn.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      items: (filter, loadProps) async {
        final searchQuery = filter;
        final int page =
            (((loadProps?.skip ?? 0) / (loadProps?.take ?? 1)) + 1).ceil();
        final sites = await cubit.loadSites(
          searchQuery: searchQuery,
          page: page,
        );
        // Check if there's an error in the cubit state after loading
        if (context.mounted) {
          final currentState = context.read<GeneratorsEnginesCubit>().state;
          if (currentState.sitesStatus.isError && currentState.error != "") {
            // Throw the error message from cubit so errorBuilder can catch it
            throw currentState.error;
          }
        }

        return sites;
      },
      onChanged: onChanged,

      validator: (value) {
        if (value == null) {
          return 'الرجاء اختيار موقع';
        }
        return null;
      },
    );
  }
}

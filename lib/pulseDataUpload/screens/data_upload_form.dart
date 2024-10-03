import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../../common/common.dart';
import '../../common/dashboard_options.dart';
import '../../salesDashboard/repo/sales_dashboard_repo.dart';
import '../../utils/cus_appbar.dart';
import '../components/dropDawns.dart';
import '../components/top_profile_name.dart';

final getDealerListProvider = FutureProvider.autoDispose((ref) async {
  final options = ref.watch(selectedOptionsProvider);
  final getDealerList = await ref
      .watch(salesRepoProvider)
      .getDealerListForEmployeeData(
          startDate: options.firstDate, endDate: options.lastDate);
  return getDealerList;
});

class UploadForm extends ConsumerWidget {
  const UploadForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dealerList = ref.watch(getDealerListProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: dealerList.when(
          data: (data) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                children: [
                  const TopProfileName(),
                  heightSizedBox(20.0),
                  DealerDropDown(data: data),
                  heightSizedBox(20.0),
                  BrandDropDown(items: modelList),
                  heightSizedBox(10.0),
                  ModelDropDawn()
                ],
              ),
            );
          },
          error: (error, stackTrace) => const Center(
            child: Text("Something went wrong"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}

final selectedDealerProvider = StateProvider<String?>((ref) => null);

class DealerDropDown extends ConsumerWidget {
  final dynamic data;
  const DealerDropDown({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedModel = ref.watch(selectedDealerProvider);

    final List<Map<String, dynamic>> products =
        List<Map<String, dynamic>>.from(data is List ? data : []);

    final List<String> modelNames = products
        .where((product) => product['BUYER'] != null)
        .map((product) => product['BUYER'] as String)
        .toList();

    if (modelNames.isEmpty) {
      return const Text("No models available");
    }

    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: selectedModel,
        style: const TextStyle(
          fontSize: 16.0,
          height: 1.5,
          color: Colors.black87,
        ),
        dropdownColor: Colors.white,
        decoration: inputDecoration(label: "Select Dealer"),
        onChanged: (newValue) {
          ref.read(selectedDealerProvider.notifier).state = newValue;
          final selectedProduct =
              products.firstWhere((product) => product['BUYER'] == newValue);
          ref.read(selectedModelIdProvider.notifier).state =
              selectedProduct['BUYER CODE'];
        },
        hint: const Text("Select Dealer"),
        items: modelNames.map<DropdownMenuItem<String>>((model) {
          final buyerCode = products
              .firstWhere((product) => product['BUYER'] == model)['BUYER CODE'];
          return DropdownMenuItem<String>(
            value: model,
            child: ListTile(
              title: Text(model), // Show the buyer
              subtitle: Text(buyerCode), // Show the buyer code
            ),
          );
        }).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a dealer';
          }
          return null; // No error
        },
        menuMaxHeight: MediaQuery.of(context).size.height / 2,
        icon: const Icon(Icons.arrow_drop_down), // Default dropdown icon
        isExpanded: true, // Ensures that dropdown stretches to fit the text
        selectedItemBuilder: (BuildContext context) {
          return modelNames.map((model) {
            return Text(
              model, // Show only the buyer (model) as selected value
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            );
          }).toList();
        },
      ),
    );
  }
}

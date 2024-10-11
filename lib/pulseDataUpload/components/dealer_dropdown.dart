import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'drop_downs.dart';

final selectedDealerProvider =
    StateProvider<Map<String, String>?>((ref) => null);

class DealerDropDown extends ConsumerWidget {
  final dynamic data;
  const DealerDropDown({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDealer = ref.watch(selectedDealerProvider);

    final List<Map<String, dynamic>> products =
        List<Map<String, dynamic>>.from(data is List ? data : []);

    final List<Map<String, String>> dealerList = products
        .where((product) =>
            product['BUYER'] != null && product['BUYER CODE'] != null)
        .map((product) => {
              'BUYER': product['BUYER'] as String,
              'BUYER CODE': product['BUYER CODE'] as String,
            })
        .toList();

    if (dealerList.isEmpty) {
      return const Center(child: Text("No dealers available"));
    }

    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        readOnly: true,
        decoration: inputDecoration(label: "Select Dealer"),
        controller: TextEditingController(
          text: selectedDealer?['BUYER'] ?? '',
        ),
        onTap: () async {
          final Map<String, String>? selectedDealer =
              await showModalBottomSheet<Map<String, String>>(
            backgroundColor: Colors.white,
            context: context,
            isScrollControlled: true,
            builder: (context) {
              String searchText = ''; // Initialize search text
              return StatefulBuilder(
                builder: (context, setState) {
                  final filteredDealers = dealerList.where((dealer) {
                    return dealer['BUYER']!
                            .toLowerCase()
                            .contains(searchText.toLowerCase()) ||
                        dealer['BUYER CODE']!
                            .toLowerCase()
                            .contains(searchText.toLowerCase());
                  }).toList();

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        const Text(
                          "Select Dealer",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        CupertinoSearchTextField(
                          placeholder: 'Search Dealer or Code',
                          onChanged: (value) {
                            setState(() {
                              searchText = value; // Update search text
                            });
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredDealers.length,
                            itemBuilder: (context, index) {
                              final dealerName =
                                  filteredDealers[index]['BUYER']!;
                              final dealerCode =
                                  filteredDealers[index]['BUYER CODE']!;

                              return ListTile(
                                title: Text(dealerName),
                                subtitle: Text(dealerCode),
                                onTap: () {
                                  Navigator.pop(context, {
                                    'BUYER': dealerName,
                                    'BUYER CODE': dealerCode,
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );

          if (selectedDealer != null) {
            ref.read(selectedDealerProvider.notifier).state = {
              'BUYER': selectedDealer['BUYER']!,
              'BUYER CODE': selectedDealer['BUYER CODE']!,
            };
          }
        },
      ),
    );
  }
}
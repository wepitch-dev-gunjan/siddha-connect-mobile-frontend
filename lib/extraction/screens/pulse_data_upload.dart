import 'package:flutter/material.dart';
import '../../utils/cus_appbar.dart';
import '../../utils/sizes.dart';
import '../components/floating_add_button.dart';

class PulseDataScreen extends StatelessWidget {
  const PulseDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopNames(),
              heightSizedBox(10.0),
              //  const  Expanded(child: ExtractionDataTable()),
            ],
          ),
        ],
      ),
      floatingActionButton: AddButton(
        onPressed: () {
          // navigateTo(const PulseUploadForm());
        },
      ),
    );
  }
}

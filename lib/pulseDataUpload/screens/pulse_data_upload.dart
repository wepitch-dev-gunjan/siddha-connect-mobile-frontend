import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/common_style.dart';
import '../../utils/cus_appbar.dart';
import '../../utils/sizes.dart';
import '../components/floating_add_button.dart';
import '../components/table.dart';

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
               const  Expanded(child: ShowTable()),
            ],
          ),
        ],
      ),
      floatingActionButton: const AddButton(),
    );
  }
}










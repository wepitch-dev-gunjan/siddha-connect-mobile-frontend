import 'package:flutter/material.dart';
import '../../utils/cus_appbar.dart';
import '../../utils/navigation.dart';
import '../../utils/sizes.dart';
import '../components/floating_add_button.dart';
import '../components/table.dart';
import 'data_upload_form.dart';

class ExtractionDataScreen extends StatelessWidget {
  const ExtractionDataScreen({super.key});

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
              const   Expanded(
                child: ExtractionDataTable(),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton:  AddButton(
        onPressed: (){
           navigateTo(const ExtractionUploadForm());
        }  
        
      ),
    );
  }
}


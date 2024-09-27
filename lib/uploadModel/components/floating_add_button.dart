import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/common_style.dart';
import '../../utils/sizes.dart';
import 'dropDawns.dart';


class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Data'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      const BrandDropDawn(
                        items: ["OPPO", "Vivo", "SAMSUNG"],
                        field: "Brand",
                      ),
                      heightSizedBox(15.0),
                      const BrandDropDawn(
                        items: ["Model 1", "Model 2", "Model 3"],
                        field: "Model",
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: const Text("OK"),
                    onPressed: () {
                      // Close the dialog
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
      shape: const CircleBorder(), // Icon inside the FAB
      backgroundColor: AppColor.primaryColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ), // Optional customization
    );
  }
}

class TopNames extends StatelessWidget {
  final dynamic data;
  const TopNames({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Dealer Code      :     ",
                style: GoogleFonts.lato(
                    fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(border: Border.all()),
                child: Center(
                  child: Text(
                    data['name'] ?? "N/A",
                    style: GoogleFonts.lato(
                        fontSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
          heightSizedBox(10.0),
          Row(
            children: [
              Text(
                "Dealer Name     :     ",
                style: GoogleFonts.lato(
                    fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Text(
                data['code'],
                style: GoogleFonts.lato(
                    fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

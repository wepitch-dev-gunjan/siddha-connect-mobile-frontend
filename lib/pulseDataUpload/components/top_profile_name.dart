import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/drawer.dart';

class TopProfileName extends ConsumerWidget {
  const TopProfileName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employData = ref.watch(userProfileProvider);
    return employData.when(
      data: (data) {
        return Column(
          children: [
            Row(
              children: [
                Text(
                  "Name   :    ",
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
          ],
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => const Center(
        child: Text("Something went wrong"),
      ),
    );
  }
}

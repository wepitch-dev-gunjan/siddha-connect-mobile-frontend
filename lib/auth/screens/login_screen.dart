import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/salesDashboard/screen/sales_dashboard.dart';
import 'package:siddha_connect/utils/fields.dart';
import 'package:siddha_connect/utils/navigation.dart';
import 'package:siddha_connect/utils/sizes.dart';

import '../../utils/buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/splashlogo.svg",
                      height: 84,
                    ),
                    heightSizedBox(8.0),
                    SvgPicture.asset(
                      "assets/images/siddhaconnect.svg",
                      height: 18,
                    )
                  ],
                ),
                heightSizedBox(50.0),
                TxtField(
                  contentPadding: contentPadding,
                  labelText: "Delar code",
                ),
                heightSizedBox(15.0),
                TxtField(
                  contentPadding: contentPadding,
                  labelText: "Password",
                ),
                heightSizedBox(15.0),
                Btn(
                  btnName: 'Log in',
                  onPressed: () {
                    navigationPush(
                      context,
                      SalesDashboard(),
                    );
                  },
                ),
                heightSizedBox(8.0),
                Text(
                  "OR",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff7F7F7F),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedBtn(btnName: "Sign up", onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}

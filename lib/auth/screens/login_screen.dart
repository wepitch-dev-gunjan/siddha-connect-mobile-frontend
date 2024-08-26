import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/auth/controllers/auth_controller.dart';
import 'package:siddha_connect/auth/screens/register_screen.dart';
import 'package:siddha_connect/utils/fields.dart';
import 'package:siddha_connect/utils/navigation.dart';
import 'package:siddha_connect/utils/sizes.dart';
import '../../utils/buttons.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKeyLogin,
        child: Padding(
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
                    labelText: "Email",
                    maxLines: 1,
                    controller: email,
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  heightSizedBox(15.0),
                  TxtField(
                    contentPadding: contentPadding,
                    labelText: "Password",
                    controller: password,
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    validator: validatePassword,
                  ),
                  heightSizedBox(15.0),
                  Btn(
                    btnName: 'Log in',
                    onPressed: () {
                      if (formKeyLogin.currentState!.validate()) {
                        ref.read(authControllerProvider).userLogin(data: {
                          "email": email.text,
                          'password': password.text
                        });
                      }
                      // navigationPush(
                      //   context,
                      //   // const SalesDashboard(),
                      // );
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
                  OutlinedBtn(
                      btnName: "Sign up",
                      onPressed: () {
                        navigateTo(const RegisterScreen());
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

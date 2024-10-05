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

final passwordHideProvider = StateProvider<bool>((ref) => false);
final selectedRoleProvider = StateProvider<String?>((ref) => null);

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final TextEditingController code = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordHide = ref.watch(passwordHideProvider);
    final selectedRole = ref.watch(selectedRoleProvider);

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
                    capitalization: TextCapitalization.characters,
                    labelText: "Code",
                    maxLines: 1,
                    controller: code,
                    keyboardType: TextInputType.text,
                    validator: validateCode,
                  ),
                  heightSizedBox(15.0),
                  TxtField(
                    contentPadding: contentPadding,
                    labelText: "Password",
                    controller: password,
                    obscureText: !isPasswordHide,
                    suffixIcon: IconButton(
                      onPressed: () {
                        ref.read(passwordHideProvider.notifier).state =
                            !isPasswordHide;
                      },
                      icon: Icon(isPasswordHide
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    validator: validatePassword,
                  ),
                  heightSizedBox(15.0),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    style: const TextStyle(
                        fontSize: 16.0, height: 1.5, color: Colors.black87),
                    decoration: InputDecoration(
                        fillColor: const Color(0XFFfafafa),
                        contentPadding: contentPadding,
                        errorStyle: const TextStyle(color: Colors.red),
                        labelStyle: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            )),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.red, // Error border color
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Color(0xff1F0A68), width: 1)),
                        labelText: "Position",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: Colors.amber, width: 0.5))),
                    value: selectedRole,
                    onChanged: (newValue) {
                      ref.read(selectedRoleProvider.notifier).state = newValue;
                    },
                    items: ['Employee', 'Dealer']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: validatePosition,
                  ),
                  heightSizedBox(25.0),
                  Btn(
                    btnName: 'Log in',
                    onPressed: () {
                      if (formKeyLogin.currentState!.validate()) {
                        ref.read(authControllerProvider).userLogin(data: {
                          "code": code.text,
                          'password': password.text,
                          'role': selectedRole!.toLowerCase(),
                        });
                      }
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

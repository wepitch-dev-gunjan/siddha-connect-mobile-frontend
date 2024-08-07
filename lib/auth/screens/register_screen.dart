import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/auth/controllers/auth_controller.dart';
import 'package:siddha_connect/auth/screens/login_screen.dart';
import 'package:siddha_connect/utils/common_style.dart';
import '../../utils/buttons.dart';
import '../../utils/fields.dart';
import '../../utils/navigation.dart';
import '../../utils/sizes.dart';


class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController position = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? selectedPosition;
    @override
  void dispose() {
 
    name.dispose();
    email.dispose();
    password.dispose();
    position.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
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
                    labelText: "Name",
                    controller: name,
                    maxLines: 1,
                    validator: validateName,
                    keyboardType: TextInputType.name,
                  ),
                  heightSizedBox(15.0),
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
                    maxLines: 1,
                    controller: password,
                    validator: validatePassword,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  heightSizedBox(15.0),
                  DropdownButtonFormField(
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
                    value: selectedPosition,
                    onChanged: (newValue) {
                      setState(() {
                        selectedPosition = newValue;
                      });
                    },
                    items: ['ZSM', 'ABM', 'RSO', 'ASE', 'ASM', 'TSE']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: validatePosition,
                  ),
                  heightSizedBox(15.0),
                  Btn(
                    btnName: 'Sign Up',
                    onPressed: () {
                      log("selectedPosition: $selectedPosition");
                      if (formKey.currentState!.validate()) {
                        ref
                            .read(authControllerProvider)
                            .registerController(data: {
                          'name': name.text,
                          'email': email.text,
                          'password': password.text,
                          "position": selectedPosition.toString()
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
                  heightSizedBox(8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        // style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      widthSizedBox(5.0),
                      GestureDetector(
                        onTap: () {
                          navigationPush(context, LoginScreen());
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColor.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class CustomDropdownButtonFormField extends StatelessWidget {
  final String? labelText, label;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownButtonFormField(
      {super.key,
      this.labelText,
      required this.items,
      this.value,
      required this.onChanged,
      this.validator,
      this.label});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      style:
          const TextStyle(fontSize: 16.0, height: 1.5, color: Colors.black87),
      decoration: InputDecoration(
        fillColor: const Color(0XFFfafafa),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        errorStyle: const TextStyle(color: Colors.red),
        labelStyle: const TextStyle(
            fontSize: 15.0, color: Colors.black54, fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.primaryColor)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xff1F0A68), width: 1)),
        labelText: labelText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.amber, width: 0.5)),
      ),
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: validator,
    );
  }
}

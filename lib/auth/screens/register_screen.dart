import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siddha_connect/auth/controllers/auth_controller.dart';
import 'package:siddha_connect/auth/screens/delar_register_screen.dart';
import 'package:siddha_connect/auth/screens/login_screen.dart';
import 'package:siddha_connect/utils/common_style.dart';
import '../../utils/buttons.dart';
import '../../utils/fields.dart';
import '../../utils/navigation.dart';
import '../../utils/sizes.dart';

final passwordHideProvider = StateProvider<bool>((ref) => false);

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  TextEditingController code = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    code.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordHide = ref.watch(passwordHideProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    labelText: "Code",
                    controller: code,
                    maxLines: 1,
                    validator: validateCode,
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
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    validator: validatePassword,
                  ),
                  heightSizedBox(15.0),
                  Btn(
                    btnName: 'Sign Up',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        ref
                            .read(authControllerProvider)
                            .registerController(data: {
                          'code': code.text,
                          'email': email.text,
                          'password': password.text,
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
                  Btn(
                    btnName: 'Register as Dealer',
                    onPressed: () {
                      navigationPush(context, DelarRegisterScreen());
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

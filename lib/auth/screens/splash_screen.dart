import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siddha_connect/auth/screens/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Column(
              children: [
                SvgPicture.asset("assets/images/splashlogo.svg"),
                SvgPicture.asset("assets/images/siddhaconnect.svg")
              ],
            ),
          ))
        ],
      ),
    );
  }
}

//  Future.delayed(const Duration(seconds: 2), () {
//       var token = ref.read(checkAuthorizeProvider);
//       log("Splash Chack => $token");
//       // navigationPush(context, const LoginImage());
//     });




// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//               child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 70),
//             child: Column(
//               children: [
//                 SvgPicture.asset("assets/images/splashlogo.svg"),
//                 SvgPicture.asset("assets/images/siddhaconnect.svg")
//               ],
//             ),
//           ))
//         ],
//       ),
//     );
//   }
// }

// resolve flutter error looking up a deactivated widget's ancestor is unsafe disini splash screen 


import 'package:dameyu_project/model/login/user_model.dart';
import 'package:dameyu_project/provider/user_provider.dart';
import 'package:dameyu_project/screen/login/login_screen.dart';
import 'package:dameyu_project/screen/navigation_bart.dart';
import 'package:dameyu_project/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLogin(context);
    });
  }

  void checkLogin(BuildContext context) async {
    String token = await SharedPref().getToken();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (!mounted) return; // Ensure the widget is still mounted
        if (token.isNotEmpty) {
          Provider.of<UserProvider>(context, listen: false).setUser(UserModel(token));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NavBar()),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEB6383),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              width: 800,
              height: 800,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

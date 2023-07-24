import 'package:flutter/material.dart';
import 'package:magadh/controller/controller.dart';
import 'package:magadh/view/home_screen/home_screen.dart';
import 'package:magadh/view/login_screen/login_screen.dart';
import 'package:magadh/view/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isloggedIn = false;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: black,
      body: Center(child: Image.asset('assets/logo.png')),
    );
  }

  void checkLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    bool loggedIn = sharedPrefs.getBool('isLoggedIn') ?? false;
    setState(() {
      isloggedIn = loggedIn;
    });
    if (isloggedIn == true) {
      await Future.delayed(
        const Duration(seconds: 1),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      await Future.delayed(
        const Duration(seconds: 1),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }
}

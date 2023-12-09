import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management_app/view/home/home_screen.dart';
import 'package:student_management_app/view/sign_up/sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    isLogedIn(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void isLogedIn(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('isLoggedIn') ?? false;

    if (FirebaseAuth.instance.currentUser!=null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
            context, SignUpScreen.routeName, (route) => false);
      });
    }
  }
}

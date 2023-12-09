import 'package:flutter/material.dart';
import 'package:student_management_app/view/add_student/add_student_screen.dart';
import 'package:student_management_app/view/home/home_screen.dart';
import 'package:student_management_app/view/phone_auth/otp_screen.dart';
import 'package:student_management_app/view/phone_auth/phone_auth_screen.dart';
import 'package:student_management_app/view/sign_in/sign_in_screen.dart';
import 'view/sign_up/sign_up_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignInScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignInScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignUpScreen());
    case PhoneAuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PhoneAuthScreen());
    case OtpScreen.routeName:
    var verifyId = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => OtpScreen(verificationId: verifyId));
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case AddStudentScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddStudentScreen());
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Something went wrong!!!"),
          ),
        ),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management_app/services/auth_services.dart';
import 'package:student_management_app/utils/error_handler.dart';
import 'package:student_management_app/view/home/home_screen.dart';
import 'package:student_management_app/view/sign_in/sign_in_screen.dart';

class AuthProvider extends ChangeNotifier {
  AuthServices authServices = AuthServices();

  bool _isLoading = false;
  bool _isPass = false;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool get isLoading => _isLoading;
  bool get isPass => _isPass;
  get signUpFormKey => _signUpFormKey;
  get signInFormKey => _signInFormKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get otpController => _otpController;

  setIsPass(bool value) {
    _isPass = value;
    notifyListeners();
  }

  // Sign up with email and password--------------------------------------------
  void signUpWithEmailAndPassword(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    if (_signUpFormKey.currentState!.validate()) {
      var response = await authServices.signUpUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response == 'success') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        }

        Fluttertoast.showToast(msg: 'Sign up successfully');
        disposeValues();
      } else if (response == 'no internet') {
        Fluttertoast.showToast(msg: 'No Internet Connection');
      } else {
        Fluttertoast.showToast(msg: getMessageFromErrorCode(response));
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  // Sign in with email and password--------------------------------------------
  void signInWithEmailAndPassword(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    if (_signInFormKey.currentState!.validate()) {
      var response = await authServices.loginUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (response == 'success') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        }

        Fluttertoast.showToast(msg: 'Login successfully');
        disposeValues();
      } else {
        Fluttertoast.showToast(msg: getMessageFromErrorCode(response));
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  // Google Sign In-------------------------------------------------------------
  void googleSignIn(BuildContext context) async {
    var response = await authServices.signInWithGoogle();

    if (response == 'success') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      }

      Fluttertoast.showToast(msg: 'Login Successfully');
      disposeValues();
    } else {
      Fluttertoast.showToast(msg: getMessageFromErrorCode(response));
    }
  }

  // Sign In with phone---------------------------------------------------------
  void signInWithPhone(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    String phoneNumber = '';

    if (phoneController.text.isNotEmpty) {
      if (phoneController.text.length == 10) {
        phoneNumber = "+91 ${phoneController.text.trim()}";
      } else {
        Fluttertoast.showToast(msg: 'Enter a vaild phone number');
      }
    } else {
      Fluttertoast.showToast(msg: 'Enter your phone number');
    }

    var response = await authServices.signInWithPhone(context, phoneNumber);

    if (response == 'success') {
      Fluttertoast.showToast(msg: 'OTP sended successfully');
    } else {
      getMessageFromErrorCode(response);
    }

    _isLoading = false;
    notifyListeners();
  }

  // verify OTP-----------------------------------------------------------------
  void verifyOtp(BuildContext context, String verificationId) async {
    _isLoading = true;
    notifyListeners();

    var response = await authServices.verifyOTP(
        verificationId: verificationId, userOTP: otpController.text.trim());

    if (response == 'success' && context.mounted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      Fluttertoast.showToast(msg: 'OTP verification success');
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      }
    } else {
      getMessageFromErrorCode(response);
    }

    _isLoading = false;
    notifyListeners();
  }

  // Sign Out-------------------------------------------------------------------
  void signOut(BuildContext context) async {
    var response = await authServices.signOut();

    if (response == 'success' && context.mounted) {
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      Fluttertoast.showToast(msg: 'Sign out Successfully');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', false);
    } else {
      Fluttertoast.showToast(msg: response);
    }
  }

  disposeValues() {
    _emailController.clear();
    _passwordController.clear();
  }
}

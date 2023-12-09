import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/controller/auth_provider.dart';
import 'package:student_management_app/widgets/auth_header.dart';
import 'package:student_management_app/widgets/custom_button.dart';
import 'package:student_management_app/widgets/custom_textfield.dart';

class OtpScreen extends StatelessWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Consumer<AuthProvider>(builder: (context, auth, _) {
            return Column(
              children: [
                const AuthHeaderWidget(title: 'Enter your OTP'),
                CustomTextField(
                  controller: auth.otpController,
                  hintText: '------',
                  inputType: TextInputType.number,
                  isOtp: true,
                ),
                const SizedBox(height: 15),
                CustomButton(
                  title: "Submit",
                  onPressed: () => auth.verifyOtp(context, verificationId),
                  isLoading: auth.isLoading ? true : false,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

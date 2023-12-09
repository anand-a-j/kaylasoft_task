import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/controller/auth_provider.dart';
import 'package:student_management_app/widgets/auth_header.dart';
import 'package:student_management_app/widgets/custom_button.dart';
import 'package:student_management_app/widgets/custom_textfield.dart';

class PhoneAuthScreen extends StatelessWidget {
  static const String routeName = '/phone-auth-screen';
  const PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Consumer<AuthProvider>(builder: (context, authProvider, _) {
            return Column(
              children: [
                const AuthHeaderWidget(title: 'Phone Number'),
                CustomTextField(
                  controller: authProvider.phoneController,
                  hintText: 'Phone Number',
                  inputType: TextInputType.phone,
                ),
                const SizedBox(height: 15),
                CustomButton(
                  title: "Submit",
                  onPressed: () => authProvider.signInWithPhone(context),
                  isLoading: authProvider.isLoading ? true : false,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/controller/auth_provider.dart';
import 'package:student_management_app/view/phone_auth/phone_auth_screen.dart';
import 'auth_divider.dart';
import 'custom_social_button.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      return Column(
        children: [
          const SizedBox(height: 30),
          const AuthDividerWidget(),
          const SizedBox(height: 30),
          CustomSoicalButton(
            title: "Continue with Google",
            iconPath: 'assets/svgs/google.svg',
            onPressed: () {
              authProvider.googleSignIn(context);
            },
          ),
          const SizedBox(height: 15),
          CustomSoicalButton(
            title: "Continue with Phone",
            iconPath: 'assets/svgs/phone.svg',
            onPressed: () {
              Navigator.pushNamed(context, PhoneAuthScreen.routeName);
            },
          ),
          const SizedBox(height: 30),
        ],
      );
    });
  }
}

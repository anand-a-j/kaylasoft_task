import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/controller/auth_provider.dart';
import 'package:student_management_app/utils/color.dart';
import 'package:student_management_app/view/sign_in/sign_in_screen.dart';
import 'package:student_management_app/widgets/auth_header.dart';
import 'package:student_management_app/widgets/custom_button.dart';
import 'package:student_management_app/widgets/custom_textfield.dart';
import 'package:student_management_app/widgets/social_login_section.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/sign-up-screen';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Consumer<AuthProvider>(builder: (context, authProvider, _) {
            return Form(
              key: authProvider.signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const AuthHeaderWidget(title: 'Create An Account'),
                  CustomTextField(
                      controller: authProvider.emailController,
                      hintText: "Email",
                      inputType: TextInputType.emailAddress,
                      ),
                  const SizedBox(height: 15),
                  CustomTextField(
                      controller: authProvider.passwordController,
                      hintText: "Password",
                      isPass: true,
                      inputType: TextInputType.visiblePassword,
                      ),
                  const SizedBox(height: 15),
                  CustomButton(
                    title: "Sign Up",
                    onPressed: () {
                      authProvider.signUpWithEmailAndPassword(context);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    isLoading: authProvider.isLoading ? true : false,
                  ),
                  const SizedBox(height: 30),
                  const SocialLoginSection(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do you have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, SignInScreen.routeName);
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: primaryColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

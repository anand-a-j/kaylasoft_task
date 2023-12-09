import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/controller/auth_provider.dart';
import 'package:student_management_app/utils/color.dart';
import 'package:student_management_app/view/sign_up/sign_up_screen.dart';
import 'package:student_management_app/widgets/auth_header.dart';
import 'package:student_management_app/widgets/custom_button.dart';
import 'package:student_management_app/widgets/custom_textfield.dart';
import 'package:student_management_app/widgets/social_login_section.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/sign-in-screen';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Consumer<AuthProvider>(builder: (context, authProvider, _) {
            return Form(
              key: authProvider.signInFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const AuthHeaderWidget(title: 'Login'),
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
                  TextButton(
                    onPressed: () {
                      
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    title: "Login",
                    onPressed: () {
                      authProvider.signInWithEmailAndPassword(context);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    isLoading: authProvider.isLoading ? true : false,
                  ),
                  const SocialLoginSection(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, SignUpScreen.routeName);
                        },
                        child: const Text(
                          "Sign Up",
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

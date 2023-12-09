import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/controller/auth_provider.dart';
import 'package:student_management_app/utils/color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autofocus;
  final TextInputType inputType;
  final bool isPass;
  final bool isOtp;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.autofocus = false,
    this.inputType = TextInputType.text,
    this.isPass = false,
    this.isOtp = false,
  });

  OutlineInputBorder enabledBorderDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(width: 2, color: kGreyShade),
    );
  }

  OutlineInputBorder borderDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(width: 2, color: primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return TextFormField(
          controller: controller,
          autofocus: autofocus,
          keyboardType: inputType,
          maxLength: isOtp ? 6 : null,
          obscureText: isPass == true
              ? auth.isPass != true
                  ? true
                  : false
              : false,
          decoration: InputDecoration(
            hintText: hintText,
            border: borderDecoration(),
            enabledBorder: enabledBorderDecoration(),
            suffixIcon: isPass
                ? IconButton(
                    onPressed: () {
                      if (auth.isPass == false) {
                        auth.setIsPass(true);
                      } else {
                        auth.setIsPass(false);
                      }
                    },
                    icon: Icon(
                      auth.isPass != true
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  )
                : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your $hintText";
            }
            if (hintText == "Email" && !isVaildEmail(value)) {
              return "Enter a vaild Email";
            }
            if (hintText == 'Password' && value.length < 6) {
              return 'Enter a strong password';
            }
            if (hintText == 'Age' && value.length > 2) {
              return 'Enter a vaild age';
            }
            return null;
          },
        );
      },
    );
  }

  isVaildEmail(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    return emailValid;
  }
}

import 'package:flutter/material.dart';
import 'package:student_management_app/utils/color.dart';

class AuthDividerWidget extends StatelessWidget {
  const AuthDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: kGreyShade,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "or",
            style: TextStyle(color: kGreyShade),
          ),
        ),
        Expanded(
          child: Divider(
            color: kGreyShade,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

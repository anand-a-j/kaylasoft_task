import 'package:flutter/material.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String title;
  const AuthHeaderWidget({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 500,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

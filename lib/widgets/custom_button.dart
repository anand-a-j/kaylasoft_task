import 'package:flutter/material.dart';
import 'package:student_management_app/utils/color.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isLoading = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,
        width: 600,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: bgColor,
                    strokeWidth: 2.5,
                  ),
                ),
              )
            : Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
      ),
    );
  }
}

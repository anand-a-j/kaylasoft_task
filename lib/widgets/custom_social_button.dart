import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_management_app/utils/color.dart';

class CustomSoicalButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final String? iconPath;

  const CustomSoicalButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,
        width: 600,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 2,
            color: kGreyShade,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconPath == null
                ? const SizedBox()
                : SvgPicture.asset(
                    iconPath!,
                    width: 25,
                  ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: kBlack,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

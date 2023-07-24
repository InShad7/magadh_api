import 'package:flutter/material.dart';
import 'package:magadh/view/utils/utils.dart';

class SignInText extends StatelessWidget {
  const SignInText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Image.asset(
          'assets/logo_.png',
          scale: 2,
        )),
        kHeight,
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            color: black,
            // fontWeight: FontWeight.bold,
          ),
        ),
        kHeight20,
        // kHeight20
      ],
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:magadh/controller/controller.dart';
import 'package:magadh/view/login_screen/widget/login_btn.dart';
import 'package:magadh/view/utils/utils.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verify OTP to continue",
              style: TextStyle(
                fontSize: 22,
                color: grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            kHeight40,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OtpField(title: otpController.text[0].toString()),
                OtpField(title: otpController.text[1].toString()),
                OtpField(title: otpController.text[2].toString()),
                OtpField(title: otpController.text[3].toString()),
                OtpField(title: otpController.text[4].toString()),
                OtpField(title: otpController.text[5].toString()),
              ],
            ),
            kHeight30,
            const LoginBtn(verify: true),
          ]),
    );
  }
}

class OtpField extends StatelessWidget {
  const OtpField({super.key, this.title});
  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: grey,
        ),
      ),
      height: mHeight! / 15,
      width: mHeight! / 15,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

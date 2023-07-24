import 'package:flutter/material.dart';
import 'package:magadh/controller/controller.dart';
import 'package:magadh/view/utils/utils.dart';


class SignUpTxtBtn extends StatelessWidget {
  const SignUpTxtBtn({super.key, this.signUp = true, required this.navigateTo});
  final signUp;
  final navigateTo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        signUp
            ? const Text(
                "New user? ",
                style: TextStyle(fontSize: 20),
              )
            : const Text(
                "Already have an account ! ",
                style: TextStyle(fontSize: 20),
              ),
        InkWell(
          child: signUp
              ? Text(
                  "Sign Up ",
                  style: TextStyle(
                    fontSize: 22,
                    color: blue,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 22,
                    color: blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          onTap: () {
            phoneController.clear();
           
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => navigateTo,
              ),
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:magadh/controller/controller.dart';
import 'package:magadh/view/login_screen/login_screen.dart';
import 'package:magadh/view/utils/utils.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({super.key, this.verify = false});
  final verify;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (verify ? false : !formKey.currentState!.validate()) {
                  Fluttertoast.showToast(
                    msg: 'Enter a valid Phone number',
                    backgroundColor: red,
                  );
                } else {
                  verify ? verifyOTP(context) : loginUser(context: context);
                }
              },
              child: Text(
                verify ? 'Verify' : 'Get OTP',
                style: TextStyle(fontSize: 24, color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

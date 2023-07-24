import 'package:flutter/material.dart';
import 'package:magadh/controller/controller.dart';
import 'package:magadh/view/login_screen/widget/text_field.dart';
import 'package:magadh/view/utils/utils.dart';
import 'widget/login_btn.dart';
import 'widget/main_card.dart';

final formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Form(
        key: formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SignInText(title: 'Sign In'),
              kHeight20,
              MyTextField(
                title: 'Mobile Number',
                icon: Icons.call,
                myControler: phoneController,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Number can\'t be empty';
                  }
                },
              ),
              kHeight30,

              const LoginBtn(),
              kHeight30,
              // SignUpTxtBtn(navigateTo: SizedBox()),
              // kHeight60,
            ]),
      ),
    );
  }
}

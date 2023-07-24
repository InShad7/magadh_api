import 'package:flutter/material.dart';
import 'package:magadh/controller/controller.dart';
import 'package:magadh/view/login_screen/login_screen.dart';
import 'package:magadh/view/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

void alertBox({context, delete = false, date}) {
  showModalBottomSheet(
    backgroundColor: grey1,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(18),
      ),
    ),
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        kHeight,
        SizedBox(
          width: 400,
          height: 70,
          child: TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', false);
              // print(prefs.getString('token'));
              phoneController.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false);
            },
            child: Text(
              'Logout',
              style: TextStyle(color: teal, fontSize: 18),
            ),
          ),
        ),
        const Divider(indent: 60, endIndent: 60),
        SizedBox(
          height: 65,
          width: 400,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: red, fontSize: 18),
            ),
          ),
        ),
        kHeight,
      ],
    ),
  );
}

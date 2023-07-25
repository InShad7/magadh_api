import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magadh/view/utils/utils.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.title,
    required this.icon,
    required this.myControler,
    this.verify = false,
    this.readOnly = false,
    this.validator,
  });
  String title;
  var myControler;
  IconData? icon;
  final verify;
  final readOnly;
  final validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Row(
        children: [
          !verify ? Image.asset('assets/india.png', scale: 12) : const SizedBox(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 12),
              margin: const EdgeInsets.all(7),
              // height: ht,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: grey1,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[0-9]"),
                    ),
                  ],
                  validator: validator,
                  readOnly: readOnly,
                  keyboardType: TextInputType.number,
                  controller: myControler,
                  cursorColor: blue,
                  style: TextStyle(color: black),
                  decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.all(5),
                    hintText: title,
                    hintStyle: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

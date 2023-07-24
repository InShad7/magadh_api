import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magadh/controller/controller.dart';
import 'package:magadh/view/utils/utils.dart';

Widget customField2({
  required String label,
  double? width,
  required bool num,
  TextEditingController? controller,
  required max,
  bool readOnly = true,
  validator,
  number = false,
  house = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " $label",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: grey)),
          width: width,
          child: customField(
              num, max, controller!, readOnly, validator, number, house),
        ),
      ],
    ),
  );
}

Widget customField(bool num, max, TextEditingController controller,
    bool readOnly, validator, number, house) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: TextFormField(
      inputFormatters: number
          ? [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.allow(
                RegExp(r"[0-9]"),
              )
            ]
          : [
              FilteringTextInputFormatter.allow(
                RegExp(r"[a-zA-Z@.]+|\s"),
              )
            ],
      validator: validator,
      readOnly: readOnly,
      cursorColor: black,
      controller: controller,
      minLines: 1,
      maxLines: max,
      keyboardType: num ? TextInputType.number : TextInputType.text,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: 'Tap to add',
        hintStyle: TextStyle(color: grey, fontSize: mHeight! / 47),
        filled: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,
      ),
      style: TextStyle(color: grey, fontSize: mHeight! / 47),
    ),
  );
}

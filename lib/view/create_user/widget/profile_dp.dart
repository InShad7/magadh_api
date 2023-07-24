import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String? myImg;

class ProfileDp extends StatefulWidget {
  const ProfileDp({super.key});

  @override
  State<ProfileDp> createState() => _ProfileDpState();
}

class _ProfileDpState extends State<ProfileDp> {
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 100,
          backgroundImage: imagePath == null
              ? AssetImage('assets/dp.jpg') as ImageProvider
              : FileImage(File(imagePath!)),
        ),
        IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {
            pickImage();
          },
        )
      ],
    );
  }

  Future<void> pickImage() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
        myImg = imagePath;
        print(myImg);
      });
    }
  }
}

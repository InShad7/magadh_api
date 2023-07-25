import 'package:flutter/material.dart';
import 'package:magadh/controller/controller.dart';
import 'package:magadh/view/utils/utils.dart';
import 'widget/field.dart';
import 'widget/profile_dp.dart';

final formKey = GlobalKey<FormState>();

class CreateUser extends StatelessWidget {
  const CreateUser({super.key, this.edit = false, this.index, this.user});
  final index;
  final edit;
  final user;

  @override
  Widget build(BuildContext context) {
    if (!edit) {
      clear();
    }
    getLocation();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: Text(edit ? 'Edit user' : 'Create user'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              edit ? ProfileDp() : SizedBox(),
              customField2(
                  label: 'Name',
                  width: mWidth!,
                  num: false,
                  max: 1,
                  controller: edit
                      ? nameController = TextEditingController(text: user.name)
                      : nameController,
                  readOnly: false,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Name can\'t be empty';
                    }
                  }),
              kHeight,
              customField2(
                  label: 'Phone number',
                  width: mWidth!,
                  num: true,
                  max: 1,
                  controller: edit
                      ? phoneController =
                          TextEditingController(text: user.phone)
                      : phoneController,
                  readOnly: false,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Number can\'t be empty';
                    }
                  },
                  number: true),
              kHeight,
              customField2(
                  label: 'Email',
                  width: mWidth!,
                  num: false,
                  max: 1,
                  controller: edit
                      ? emailController =
                          TextEditingController(text: user.email)
                      : emailController,
                  readOnly: false,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Email can\'t be empty';
                    }
                  }),
              Row(
                children: [
                  customField2(
                      label: 'Latitude',
                      width: mWidth! / 2.4,
                      num: true,
                      max: 1,
                      controller: latController,
                      readOnly: true,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'latitude can\'t be empty';
                        }
                      }),
                  kHeight,
                  customField2(
                      label: 'Longitude',
                      width: mWidth! / 2.6,
                      num: true,
                      max: 1,
                      controller: lonController,
                      readOnly: true,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'longtitude can\'t be empty';
                        }
                      }),
                ],
              ),
              kHeight,
              kHeight40,
              Container(
                height: 50,
                margin: const EdgeInsets.all(12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    edit
                        ? updateUser(
                            imagePath: myImg,
                            userId: user.id,
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            latitude: latController.text,
                            longitude: lonController.text,
                          )
                        : createUser(
                            email: emailController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            latitude: latController.text,
                            longitude: lonController.text,
                            context: context,
                          );
                    edit ? Navigator.pop(context) : null;
                    clear();
                  },
                  child: Text(edit ? "Update" : 'Create'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

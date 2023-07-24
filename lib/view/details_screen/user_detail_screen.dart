import 'package:flutter/material.dart';
import 'package:magadh/controller/controller.dart';
import 'package:magadh/view/create_user/create_user.dart';

import 'package:magadh/view/utils/utils.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key, this.user});
  final user;
  @override
  Widget build(BuildContext context) {
    getPlaceName(latitude: user.latitude, longitude: user.longitude);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateUser(edit: true, user: user),
                ),
              );
            },
          ),
        ],
      ),
      body: SizedBox(
        height: mHeight! / 1.8,
        width: mWidth,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kHeight,
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/dp.jpg'),
              ),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.email,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: grey,
                ),
              ),
              Text(
                user.phone,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: grey,
                ),
              ),
              SizedBox(
                width: 300,
                child: Text(
                  locationName.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: grey,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

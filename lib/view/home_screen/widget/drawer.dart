import 'package:flutter/material.dart';
import 'package:magadh/view/create_user/create_user.dart';
import 'package:magadh/view/home_screen/widget/alert.dart';
import 'package:magadh/view/login_screen/login_screen.dart';
import 'package:magadh/view/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawers extends StatelessWidget {
  const NavigationDrawers({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(children: [
          buildHeader(context),
          buildMenuItems(context),
        ]),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      color: Colors.blue.shade700,
      width: MediaQuery.of(context).size.width,
      padding:
          EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 24),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage('assets/dp.jpg'),
          ),
          kHeight,
          Text(
            userName.toString(),
            style: TextStyle(fontSize: 20, color: white),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Create user'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateUser(),
                  ),
                );
              },
            ),
            kHeight,
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () async {
                alertBox(context: context);
              },
            ),
          ],
        ),
      );
}

String? userName;
Future<void> getName() async {
  final prefs = await SharedPreferences.getInstance();
  userName = prefs.getString('name') ?? 'User name';
  print(prefs.getString('name'));
}

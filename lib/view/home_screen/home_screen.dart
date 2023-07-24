import 'package:flutter/material.dart';
import 'package:magadh/controller/controller.dart';
import 'widget/app_bar.dart';
import 'widget/drawer.dart';
import 'widget/item_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getName();
    mHeight = MediaQuery.of(context).size.height;
    mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: homeKey,
      appBar: const CustomAppBar(),
      drawer: const NavigationDrawers(),
      body: FutureBuilder(
        future: getUserList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!;
            return ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                final user = userData[index];
                
                return ItemTile(user: user);
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to fetch data'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

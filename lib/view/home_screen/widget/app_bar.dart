import 'package:flutter/material.dart';
import 'package:magadh/controller/controller.dart';
import 'package:magadh/view/utils/utils.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  final Size preferredSize = const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'assets/logo.png',
        scale: 20,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: white,
        ),
        onPressed: () {
          homeKey.currentState!.openDrawer();
        },
      ),
      backgroundColor: black,
      automaticallyImplyLeading: false,
    );
  }
}

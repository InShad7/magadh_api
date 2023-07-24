import 'package:flutter/material.dart';
import 'package:magadh/controller/controller.dart';
import 'package:magadh/view/details_screen/user_detail_screen.dart';
import 'package:magadh/view/utils/utils.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
    required this.user,
  });

  final user;

  @override
  Widget build(BuildContext context) {
    getPlaceName(latitude: user.latitude, longitude: user.longitude);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailsScreen(user: user),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        color: white,
        child: ListTile(
          title: Text(user.name),
        ),
      ),
    );
  }
}

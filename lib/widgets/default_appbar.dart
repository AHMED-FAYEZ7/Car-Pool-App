import 'package:flutter/material.dart';
import 'package:kau_carpool/layout/app_layout.dart';
import 'package:kau_carpool/pages/register/register_page.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  final double height;
  DefaultAppBar({
    required this.title,
    this.height = kToolbarHeight,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      titleSpacing: 20.0,
      backgroundColor: Colors.transparent,
      title: Text(
        title!,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
      ),
      leading: GestureDetector(
        child: const Image(
          image: AssetImage("assets/images/left_arrow_ic.png"),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppLayout(),
            ),
          );

        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

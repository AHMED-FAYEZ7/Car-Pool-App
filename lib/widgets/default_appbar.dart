import 'package:flutter/material.dart';
import 'package:kau_carpool/layout/app_layout.dart';

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
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => AppLayout(),
              ),
                  (route)
              {
                return false;
              }
          );

        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

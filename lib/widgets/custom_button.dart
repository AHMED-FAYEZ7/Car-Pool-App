
import 'package:flutter/material.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, this.onTap, required this.text, this.width}) : super(key: key);
  VoidCallback? onTap;
  String text;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ColorManager.primary),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorManager.white,
              fontFamily: "Jost",
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ),
    );
  }
}

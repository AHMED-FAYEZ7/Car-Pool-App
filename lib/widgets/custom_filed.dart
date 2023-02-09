
import 'package:flutter/material.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';

class CustomField extends StatelessWidget {
  CustomField({Key? key,
    this.hintText,
    this.icPath,
    this.onChanged,
    this.obscureText = false,
    this.read = false,
    required this.controller,
    this.type,
    this.suffix,
    this.onTap,
    this.suffixPressed,
    required this.validator,
  }) : super(key: key);
  Function(String)? onChanged;
  String? hintText;
  String? icPath;
  IconData? suffix;
  TextEditingController controller;
  TextInputType? type;
  Function? suffixPressed;
  GestureTapCallback? onTap;
  String? Function(String? val)? validator;
  bool? obscureText;
  bool? read;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 40,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: obscureText!,
        validator: validator,
        readOnly: read!,
        onChanged: onChanged,
        onTap: () {
          onTap!();
        },
        decoration: InputDecoration(
          icon: SizedBox(
            height: 25,
            width: 25,
            child: Center(
              child: Image.asset("$icPath"),
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              suffix,
              size: 20,
              color: ColorManager.darkGrey,
            ),
            onPressed: () {
              suffixPressed!();
            },
          ),
          hintText: hintText,
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          hintStyle: TextStyle(
            color: ColorManager.darkGrey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ColorManager.grey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: ColorManager.black,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';

class CustomField extends StatelessWidget {
  CustomField({
    this.hintText,
    this.icPath,
    this.onChanged ,
    this.obscureText =false,
    required this.controller,
    required this.type,
    this.suffix,
    this.suffixPressed,
    required this.validator,
  });
  Function(String)? onChanged;
  String? hintText;
  String? icPath;
  IconData? suffix;
  TextEditingController controller;
  TextInputType? type;
  Function? suffixPressed;
  String? Function(String? val)? validator;
  bool? obscureText;

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
        obscureText:obscureText!,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Container(
            height: 25,
              width: 25,
              child: Center(child: Image.asset("$icPath"))),
          suffixIcon: IconButton(
            icon : Icon(
              suffix,
              size: 20,
              color: ColorManager.darkGrey,
            ),
            onPressed: (){
              suffixPressed!();
            },
          ),
          hintText: hintText,
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          hintStyle: TextStyle(
            color: ColorManager.darkGrey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color:ColorManager.grey,
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
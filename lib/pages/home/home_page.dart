import 'package:flutter/material.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/widgets/custom_toggle_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text(
            "Start Your Carpool Journey with",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "KAU CARPOOL",
            style: TextStyle(
              fontSize: 20,
              color: ColorManager.primary,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Image(
            image: AssetImage("assets/images/splash_logo.png"),
            height: 170,
            width: 170,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset.zero,
                      blurRadius: 20,
                      color: ColorManager.white,
                    ),
                  ]),
              child: Column(
                children: [
                  SizedBox(height :70 ,child: CustomToggleButton()),
                  Expanded(
                    child: Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset.zero,
                              blurRadius: 20,
                              color: ColorManager.white,
                            ),
                          ]),
                      child: Container(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

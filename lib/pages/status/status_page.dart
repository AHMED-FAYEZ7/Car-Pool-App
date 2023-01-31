// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/layout/app_layout.dart';
import 'package:kau_carpool/widgets/custom_button.dart';
import 'package:kau_carpool/widgets/default_appbar.dart';

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Request Status"),
      extendBodyBehindAppBar: false,
      backgroundColor: ColorManager.backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 80 / 100,
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
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 90.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "Your request has been \n rejected",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.black,
                          fontFamily: "Jost",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  CustomButton(
                    width: 150,
                    text: "Home",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppLayout(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

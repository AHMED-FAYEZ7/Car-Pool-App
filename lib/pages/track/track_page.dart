// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/widgets/default_appbar.dart';

class TrackPage extends StatelessWidget {
  TrackPage({Key? key}) : super(key: key);
  static String id = 'TrackPage';
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: DefaultAppBar(
        title: "Track Your Trip",
      ),
      backgroundColor: ColorManager.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 1,
              horizontal: 50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Image(
                  image: AssetImage("assets/images/track_ic.png"),
                  height: 100,
                  width: 50,
                ),
              ],
            ),
          ),
          Container(
            height: 550,
            // height: MediaQuery.of(context).size.height * 80 / 100,
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircleAvatar(
                                radius: 25.0,
                                backgroundImage:
                                    AssetImage("assets/images/person_ic.png")),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Driver : @Driver name',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Jost",
                              ),
                              textAlign: TextAlign.justify,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const Text(
                          'Phone Number : 05xxxxxxx',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Jost",
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
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

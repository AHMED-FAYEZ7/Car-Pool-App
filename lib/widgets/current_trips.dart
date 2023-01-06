import 'package:flutter/material.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/widgets/custom_button.dart';

class CurrentTripsWidget extends StatelessWidget {
  const CurrentTripsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 220,
            decoration: BoxDecoration(
                color: ColorManager.backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset.zero,
                    blurRadius: 20,
                    color: ColorManager.white,
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      'Phone Number : 05xxxxxxxx',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Image.asset('assets/images/min_person_ic.png'),
                      SizedBox(width: 10,),
                      Text(
                        'Driver : Sara Ahmed',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Image.asset('assets/images/drop_off_ic.png'),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          'Destinition : King Abdulaziz University , Gate 2',
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 50,
          child: CustomButton(
            text: "Track",
          ),
        ),
      ],
    );
  }
}

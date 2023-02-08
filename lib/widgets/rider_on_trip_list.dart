// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:kau_carpool/models/trip_selectors_model.dart';
import 'package:kau_carpool/models/trips_model.dart';

class RiderOnTripListBuilder extends StatelessWidget {
  RiderOnTripListBuilder({
    required this.model,
    required this.context,
    required this.index,
  });
  BuildContext context;
  int index;
  SelectedTripModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: const [
                  CircleAvatar(
                      radius: 40.0,
                      backgroundImage:
                          AssetImage("assets/images/person_ic.png")),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 3.0,
                  end: 3.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${model.rate}',
                      style: TextStyle(
                        fontFamily: "Jost",
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Jost",
                  ),
                  textAlign: TextAlign.justify,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Container(
            width: 30,
            height: 30,
            // color: Color(Colors.amber),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/message_ic.png"),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
    );
  }

}

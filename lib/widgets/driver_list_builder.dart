import 'package:flutter/material.dart';
import 'package:kau_carpool/models/trips_model.dart';

class ListBuilder extends StatelessWidget {
  ListBuilder({
    required this.model,
    required this.context,
    required this.index,
});
  BuildContext context;
  int index;
  TripsModel model;

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
                      radius: 50.0,
                      backgroundImage: AssetImage("assets/images/person_ic.png")
                      // NetworkImage(
                      //   'https://www.befunky.com/images/prismic/5ddfea42-7377-4bef-9ac4-f3bd407d52ab_landing-photo-to-cartoon-img5.jpeg?auto=avif,webp&format=jpg&width=863',
                      // ),
                      ),
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
                      "4.5/8",
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
          SizedBox(
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Estimated arrival time: ${model.dateTime}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Jost",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Number of people in car: ${model.numberOfSeats}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Jost",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';
import 'package:kau_carpool/helper/places_webservices.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/pages/map/cubit/maps_cubit.dart';
import 'package:kau_carpool/pages/map/map_screen.dart';
import 'package:kau_carpool/pages/requests/driver_requests_page.dart';
import 'package:kau_carpool/pages/requests/rider_requests_page.dart';
import 'package:kau_carpool/repository/maps_repo.dart';
import 'package:kau_carpool/widgets/custom_button.dart';
import 'package:kau_carpool/widgets/custom_filed.dart';
import 'package:kau_carpool/widgets/custom_toggle_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var findPickUpController = TextEditingController();
  var offerPickUpController = TextEditingController();
  var findDropOffController = TextEditingController();
  var offerDropOffController = TextEditingController();
  var numOfSetsController = TextEditingController();
  var findDateAndTimeController = TextEditingController();
  var offerDateAndTimeController = TextEditingController();
  var findKey = GlobalKey<FormState>();
  var offerKey = GlobalKey<FormState>();
  // String _currentLocation = "Your current location";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

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
                      SizedBox(
                          height: 70,
                          child: CustomToggleButton(
                            tab1: 'Find Pool',
                            tab2: 'Offer Pool',
                            selectedIndex: cubit.homeToggleIndex,
                            onItemSelected: (index) {
                              cubit.homeToggleButton(index);
                              print(cubit.homeToggleIndex);
                            },
                          )),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                if (state is FindToggle ||
                                    state is! OfferToggle)
                                  Form(
                                    key: findKey,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                  create: (context) =>
                                                      MapsCubit(
                                                    MapsRepository(
                                                      PlacesWebservices(),
                                                    ),
                                                  ),
                                                  child: MapScreen(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: CustomField(
                                            icPath:
                                                "assets/images/pick_up_ic.png",
                                            hintText: "Enter Pick up location",
                                            controller: findPickUpController,
                                            type: TextInputType.text,
                                            validator: (String? s) {
                                              return null;
                                            },
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                  create: (context) =>
                                                      MapsCubit(
                                                    MapsRepository(
                                                      PlacesWebservices(),
                                                    ),
                                                  ),
                                                  child: MapScreen(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: CustomField(
                                            icPath:
                                                "assets/images/drop_off_ic.png",
                                            hintText: "Enter Drop Off Location",
                                            controller: findDropOffController,
                                            type: TextInputType.text,
                                            validator: (String? s) {
                                              return null;
                                            },
                                          ),
                                        ),
                                        CustomField(
                                          write: true,
                                          icPath:
                                              "assets/images/date_time_ic.png",
                                          hintText: "Enter Date & Time",
                                          controller: findDateAndTimeController,
                                          type: TextInputType.text,
                                          validator: (String? s) {
                                            if (s!.isEmpty) {
                                              return 'Please Enter Date & Time';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomButton(
                                          width: 110,
                                          text: "Find Pool",
                                          onTap: () {
                                            if (findKey.currentState!.validate()) {
                                              cubit.createFindPool(
                                                dateTime: findDateAndTimeController.text,
                                                pickUpLocation: "mansoura",
                                                dropOffLocation: "alex",
                                              );
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DriverRequestsPage(),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                if (state is OfferToggle)
                                  Form(
                                    key: offerKey,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                  create: (context) =>
                                                      MapsCubit(
                                                    MapsRepository(
                                                      PlacesWebservices(),
                                                    ),
                                                  ),
                                                  child: MapScreen(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: CustomField(
                                            icPath:
                                                "assets/images/pick_up_ic.png",
                                            hintText: "Enter Pick up Location",
                                            controller: offerPickUpController,
                                            type: TextInputType.text,
                                            validator: (String? s) {
                                              return null;
                                            },
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                  create: (context) =>
                                                      MapsCubit(
                                                    MapsRepository(
                                                      PlacesWebservices(),
                                                    ),
                                                  ),
                                                  child: MapScreen(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: CustomField(
                                            icPath:
                                                "assets/images/drop_off_ic.png",
                                            hintText: "Enter Drop Off Location",
                                            controller: offerDropOffController,
                                            type: TextInputType.text,
                                            validator: (String? s) {
                                              return null;
                                            },
                                          ),
                                        ),
                                        CustomField(
                                          write: true,
                                          icPath:
                                              "assets/images/date_time_ic.png",
                                          hintText: "Enter Date & Time",
                                          controller:
                                              offerDateAndTimeController,
                                          type: TextInputType.text,
                                          validator: (String? s) {
                                            if (s!.isEmpty) {
                                              return 'Please Enter Date & Time';
                                            }
                                            return null;
                                          },
                                        ),
                                        CustomField(
                                          write: true,
                                          icPath: "assets/images/seats_ic.png",
                                          hintText: "Enter Number Of Seats",
                                          controller: numOfSetsController,
                                          type: TextInputType.text,
                                          validator: (String? s) {
                                            if (s!.isEmpty) {
                                              return 'Please Add Number Of Seats';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomButton(
                                          width: 110,
                                          text: "Offer Pool",
                                          onTap: () {
                                            // print(address!);
                                            cubit.createOfferPool(
                                              pickUpLocation: "cairo",
                                              dropOffLocation: "gazaan",
                                              dateTime: offerDateAndTimeController.text,
                                              numberOfSeats: numOfSetsController.text,
                                            );

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RiderRequestsPage(),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

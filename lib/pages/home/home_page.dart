import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:kau_carpool/constants.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';
import 'package:kau_carpool/helper/app_prefs.dart';
import 'package:kau_carpool/helper/constant.dart';
import 'package:kau_carpool/helper/location_helper.dart';
import 'package:kau_carpool/helper/places_webservices.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/pages/requests/driver_requests_page.dart';
import 'package:kau_carpool/pages/requests/rider_requests_page.dart';
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
  late double? pickLat;
  late double? pickLng;
  late double? dropLat;
  late double? dropLng;
  List<Placemark>? placemarks;
  Placemark? placemark;
  Position? position;
  String? getLocationAddress;
  String? getCurrentDescription;
  String? getCurrentDescriptionAddress;

  getLocation() async {
    position = await LocationHelper.getCurrentLocation();
    placemarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );
    placemark = placemarks![0];
    setState(() {
      getLocationAddress =
          "${placemark!.administrativeArea}, ${placemark!.subAdministrativeArea}, ${placemark!.locality}, ${placemark!.subLocality}, ${placemark!.thoroughfare}, ${placemark!.subThoroughfare}, ${placemark!.country}";
    });
  }

  getCurrentAddress() async {
    getCurrentDescription = await PlacesWebservices.getAddressFromCoordinates(
      position!.latitude,
      position!.longitude,
    );
    setState(() {
      getCurrentDescriptionAddress = getCurrentDescription!;
    });
  }

  picUpField() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 40,
      ),
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: findPickUpController,
          googleAPIKey: googleAPIKey,
          inputDecoration: InputDecoration(
            prefixIcon: Icon(Icons.location_on_outlined),
            hintText: getLocationAddress ?? "Enter Pick Up Location",
            hintStyle: TextStyle(
              color: ColorManager.darkGrey,
            ),
            icon: Container(
              height: 25,
              width: 25,
              child: Center(
                child: Image.asset("assets/images/pick_up_ic.png"),
              ),
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
                color: ColorManager.primary,
              ),
            ),
          ),
          debounceTime: 800,
          countries: ["sa"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            pickLat = double.parse(prediction.lat!);
            pickLng = double.parse(prediction.lng!);
            CacheHelper.saveData(key: "startLat", value: pickLat).then((value) {
              StartLat = pickLat;
            });
            CacheHelper.saveData(key: "startLng", value: pickLng).then((value) {
              StartLng = pickLng;
            });
          },
          itmClick: (Prediction prediction) {
            findPickUpController.text = prediction.description!;

            findPickUpController.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length),
            );
          }
          // default 600 ms ,
          ),
    );
  }

  dropOffField() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 40,
      ),
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: findDropOffController,
          googleAPIKey: googleAPIKey,
          inputDecoration: InputDecoration(
            prefixIcon: Icon(Icons.car_repair_outlined),
            hintText: "Enter Drop Off Location",
            hintStyle: TextStyle(
              color: ColorManager.darkGrey,
            ),
            icon: Container(
              height: 25,
              width: 25,
              child: Center(
                child: Image.asset("assets/images/drop_off_ic.png"),
              ),
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
                color: ColorManager.primary,
              ),
            ),
          ),
          debounceTime: 800,
          countries: ["sa"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            dropLat = double.parse(prediction.lat!);
            dropLng = double.parse(prediction.lng!);
            CacheHelper.saveData(key: "endLat", value: dropLat).then((value) {
              EndLat = dropLat;
            });
            CacheHelper.saveData(key: "endLng", value: dropLng).then((value) {
              EndLng = dropLng;
            });
          },
          itmClick: (Prediction prediction) {
            findDropOffController.text = prediction.description!;

            findDropOffController.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
          }
          // default 600 ms ,
          ),
    );
  }

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
                                        picUpField(),
                                        dropOffField(),
                                        CustomField(
                                          icPath:
                                              "assets/images/date_time_ic.png",
                                          hintText: "Enter Date & Time",
                                          controller: findDateAndTimeController,
                                          read: true,
                                          validator: (String? s) {
                                            if (s!.isEmpty) {
                                              return 'Please Enter Date & Time';
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            await selectDate(findDateAndTimeController);
                                            await selectTime(findDateAndTimeController);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomButton(
                                          width: 110,
                                          text: "Find Pool",
                                          onTap: () async {
                                            if (findKey.currentState!
                                                .validate()) {
                                              cubit.createFindPool(
                                                dateTime:
                                                    findDateAndTimeController
                                                        .text,
                                                pickUpLocation:
                                                    findPickUpController.text,
                                                dropOffLocation: "alex",
                                                    // findDropOffController.text,
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
                                        picUpField(),
                                        dropOffField(),
                                        CustomField(
                                          read: true,
                                          icPath:
                                              "assets/images/date_time_ic.png",
                                          hintText: "Enter Date & Time",
                                          controller:
                                              offerDateAndTimeController,
                                          onTap: () async
                                          {
                                            await selectDate(offerDateAndTimeController);
                                            await selectTime(offerDateAndTimeController);
                                          },
                                          validator: (String? s) {
                                            if (s!.isEmpty) {
                                              return 'Please Enter Date & Time';
                                            }
                                            return null;
                                          },
                                        ),
                                        CustomField(
                                          icPath: "assets/images/seats_ic.png",
                                          hintText: "Enter Number Of Seats",
                                          controller: numOfSetsController,
                                          type: TextInputType.number,
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
                                            cubit.createOfferPool(
                                              pickUpLocation:

                                                      findPickUpController.text,
                                              dropOffLocation: "alex",
                                                  // findDropOffController.text,
                                              dateTime:
                                                  offerDateAndTimeController
                                                      .text,
                                              numberOfSeats:
                                                  numOfSetsController.text,
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorManager.primary,
            child: Icon(
              Icons.place,
              color: ColorManager.white,
            ),
            onPressed: () async {
              await getLocation();

              await getCurrentAddress();
              print("current address ${getLocationAddress}");
              print("current address ${getCurrentDescriptionAddress}");
            },
          ),
        );
      },
    );
  }

  DateTime? selectedDate;

  Future<void> selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = "${selectedDate!.toLocal()}";
      });
    }
  }

  Future<void> selectTime(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate ?? DateTime.now()),
    );
    if (picked != null) {
      setState(() {
        int hour = picked.hour;
        String period = 'am';
        if (hour == 0) {
          hour = 12;
        } else if (hour == 12) {
          period = 'pm';
        } else if (hour > 12) {
          hour -= 12;
          period = 'pm';
        }
        selectedDate = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          hour,
          picked.minute,
        );
        controller.text = "${selectedDate!.toLocal().toString().substring(0, 16)} $period";
      });
    }
  }
}

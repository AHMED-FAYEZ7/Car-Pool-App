import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
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
  var findDropOffController = TextEditingController();
  var findKey = GlobalKey<FormState>();
  var offerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener:(context, state) {} ,
      builder:(context, state) {
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
                      SizedBox(height :70 ,
                          child: CustomToggleButton(
                            selectedIndex: cubit.toggleIndex,
                            onItemSelected: (index){
                              cubit.toggleButton(index);
                              print(cubit.toggleIndex);
                            },
                          )
                      ),
                      Expanded(
                        child: Container(
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
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                if(state is FindToggle || state is !OfferToggle)
                                  Form(
                                    key: findKey,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10,),
                                        CustomField(
                                          icPath: "assets/images/pick_up_ic.png",
                                          hintText: "Enter Pick up Location",
                                          controller: findPickUpController,
                                          type: TextInputType.text,
                                          validator: (String? s)
                                          {
                                            if(s!.isEmpty)
                                            {
                                              return 'Please Enter Location';
                                            }
                                            return null;
                                          },
                                        ),
                                        CustomField(
                                          icPath: "assets/images/drop_off_ic.png",
                                          hintText: "Enter Drop Off Location",
                                          controller: findPickUpController,
                                          type: TextInputType.text,
                                          validator: (String? s)
                                          {
                                            if(s!.isEmpty)
                                            {
                                              return 'Please Enter Location';
                                            }
                                            return null;
                                          },
                                        ),
                                        CustomField(
                                          icPath: "assets/images/date_time_ic.png",
                                          hintText: "Enter Date & Time",
                                          controller: findPickUpController,
                                          type: TextInputType.text,
                                          validator: (String? s)
                                          {
                                            if(s!.isEmpty)
                                            {
                                              return 'Please Add Date and Time';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 20,),
                                        CustomButton(
                                          width: 110,
                                          text: "Find Pool",
                                          onTap: () {
                                            if(findKey.currentState!.validate())
                                            {

                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                if(state is OfferToggle)
                                  Form(
                                    key: offerKey,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10,),
                                        CustomField(
                                          icPath: "assets/images/pick_up_ic.png",
                                          hintText: "Enter Pick up Location",
                                          controller: findPickUpController,
                                          type: TextInputType.text,
                                          validator: (String? s)
                                          {
                                            if(s!.isEmpty)
                                            {
                                              return 'Please Enter Location';
                                            }
                                            return null;
                                          },
                                        ),
                                        CustomField(
                                          icPath: "assets/images/drop_off_ic.png",
                                          hintText: "Enter Drop Off Location",
                                          controller: findPickUpController,
                                          type: TextInputType.text,
                                          validator: (String? s)
                                          {
                                            if(s!.isEmpty)
                                            {
                                              return 'Please Enter Location';
                                            }
                                            return null;
                                          },
                                        ),
                                        CustomField(
                                          icPath: "assets/images/date_time_ic.png",
                                          hintText: "Enter Date & Time",
                                          controller: findPickUpController,
                                          type: TextInputType.text,
                                          validator: (String? s)
                                          {
                                            if(s!.isEmpty)
                                            {
                                              return 'Please Add Date and Time';
                                            }
                                            return null;
                                          },
                                        ),
                                        CustomField(
                                          icPath: "assets/images/seats_ic.png",
                                          hintText: "Enter Number Of Seats",
                                          controller: findPickUpController,
                                          type: TextInputType.text,
                                          validator: (String? s)
                                          {
                                            if(s!.isEmpty)
                                            {
                                              return 'Please Add Number Of Seats';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 20,),
                                        CustomButton(
                                          width: 110,
                                          text: "Offer Pool",
                                          onTap: () {
                                            if(offerKey.currentState!.validate())
                                            {

                                            }
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
      } ,
    );
  }
}

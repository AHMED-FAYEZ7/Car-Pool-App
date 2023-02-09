
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/layout/app_layout.dart';
import 'package:kau_carpool/pages/confirm/confirm_page.dart';
import 'package:kau_carpool/pages/status/status_page.dart';
import 'package:kau_carpool/widgets/custom_button.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';

class WaitPage extends StatelessWidget {
  WaitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var your_controller;
    return Scaffold(
          extendBodyBehindAppBar: false,
          backgroundColor: ColorManager.backgroundColor,
          body: BlocConsumer<AppCubit,AppState>(
              listener: (context ,state){
                if(state is AppSelectTripsSuccessState){
                  AppCubit.get(context).getSelectedTrips(state.id);
                }
                if(state is AppSelectedTripsAcceptedState){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmPage(),
                    ),
                  );
                }
                if(state is AppSelectedTripsRefusedState) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusPage(),
                    ),
                  );
                }
              },
            builder: (context, state){
                  return SingleChildScrollView(
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
                                height: 20.0,
                              ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: NeonCircularTimer(
                                    width: 200,
                                    duration: 300,
                                    isReverse: true,
                                    controller : your_controller,
                                    isTimerTextShown: true,
                                    neumorphicEffect: true,
                                    textFormat: TextFormat.MM_SS,
                                    backgroudColor: ColorManager.white,
                                    innerFillGradient: LinearGradient(colors: [
                                      ColorManager.primary,
                                      ColorManager.primary
                                    ]),
                                    neonGradient: LinearGradient(colors: [
                                      ColorManager.primary,
                                      ColorManager.primary,
                                    ]),
                                    onComplete: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => StatusPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: Text(
                                    "Waiting for the driver to accept your request",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.grey,
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
                                text: "Cancel",
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
                  );
                },
          ),
        );
      }
}

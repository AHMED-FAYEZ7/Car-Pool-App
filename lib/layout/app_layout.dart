import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';
import 'package:kau_carpool/models/user_model.dart';

import '../helper/resources/color_manager.dart';

class AppLayout extends StatelessWidget {
  AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavyBar(
              backgroundColor: ColorManager.primary,
              selectedIndex: cubit.currentIndex,
              onItemSelected: (index) {
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavyBarItem(
                  icon: Image.asset("assets/images/home_ic.png"),
                  title: const Center(
                      child: Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  activeColor: ColorManager.white,
                  inactiveColor: ColorManager.black,
                ),
                BottomNavyBarItem(
                  icon: Image.asset("assets/images/trips_ic.png"),
                  title: const Center(
                    child: Text(
                      "Trips",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  activeColor: ColorManager.white,
                  inactiveColor: ColorManager.black,
                ),
                BottomNavyBarItem(
                  icon: Image.asset("assets/images/more_ic.png"),
                  title: const Center(
                      child: Text(
                    "More",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  activeColor: ColorManager.white,
                  inactiveColor: ColorManager.black,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

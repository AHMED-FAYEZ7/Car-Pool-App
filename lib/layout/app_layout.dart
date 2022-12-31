import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';

import '../helper/resources/color_manager.dart';

class AppLayout extends StatelessWidget {
  AppLayout({Key? key}) : super(key: key);
  static String id = 'LayoutPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppState>(
        listener: (context,state) {},
        builder: (context,state)
        {
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavyBar(
              backgroundColor: ColorManager.primary,
              selectedIndex: cubit.currentIndex,
              showElevation: true, // use this to remove appBar's elevation
              onItemSelected: (index) {
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavyBarItem(
                    icon: Icon(Icons.home),
                    title: Text("home"),
                    activeColor: ColorManager.white,
                    inactiveColor: ColorManager.black
                ),
                BottomNavyBarItem(
                    icon: Icon(Icons.car_rental),
                    title: Text("categories"),
                    activeColor: ColorManager.white,
                    inactiveColor: ColorManager.black
                ),
                BottomNavyBarItem(
                    icon: Icon(Icons.more),
                    title: Text("favorites"),
                    activeColor: ColorManager.white,
                    inactiveColor: ColorManager.black
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ignore_for_file: sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';
import 'package:kau_carpool/helper/app_prefs.dart';
import 'package:kau_carpool/helper/constant.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/pages/wait/wait_page.dart';
import 'package:kau_carpool/widgets/default_appbar.dart';
import 'package:kau_carpool/widgets/driver_list_builder.dart';

class DriverRequestsPage extends StatelessWidget {
  DriverRequestsPage({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is AppCreateFindsSuccessState){
          AppCubit.get(context).getTrips(dropOffLocation: dropOff);
        }
        if(state is AppGetTripsSuccessState){
          CacheHelper.removeData(key: 'dropOffLocation');
        }
      },
      builder: (context, state) {
        return WillPopScope(
            onWillPop: () async {
          CacheHelper.removeData(key: 'dropOffLocation');
          return true;
        },
        child:Scaffold(
          extendBodyBehindAppBar: false,
          appBar: DefaultAppBar(
            title: "Select a Driver",
          ),
          backgroundColor: ColorManager.backgroundColor,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            Center(
                              child: Container(
                                width: 350,
                                height: 50,
                                child: TextField(
                                  onChanged: (value) {
                                    //  searchData(st = value.trim().toLowerCase());
                                    // Method For Searching
                                  },
                                  textAlign: TextAlign.justify,
                                  decoration: const InputDecoration(
                                    hintText: "Search for a driver",
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  AppCubit.get(context).tripsSelects(
                                      AppCubit.get(context).tripsId[index]);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WaitPage(),
                                    ),
                                  );
                                },
                                child: DriverListBuilder(
                                  model: AppCubit.get(context).trips[index],
                                  context: context,
                                  index: index,
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 20.0,
                              ),
                              itemCount: AppCubit.get(context).trips.length,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}

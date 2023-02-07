// ignore_for_file: sized_box_for_whitespace, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/models/trips_model.dart';
import 'package:kau_carpool/pages/wait/wait_page.dart';
import 'package:kau_carpool/widgets/default_appbar.dart';
import 'package:kau_carpool/widgets/driver_list_builder.dart';

class DriverRequestsPage extends StatefulWidget {
  DriverRequestsPage({Key? key}) : super(key: key);

  @override
  State<DriverRequestsPage> createState() => _DriverRequestsPageState();
}

class _DriverRequestsPageState extends State<DriverRequestsPage> {
  var formKey = GlobalKey<FormState>();
  String searchString = "";
  List<TripsModel> trips = [];
  List<TripsModel> filteredTrips = [];

  @override
  Widget build(BuildContext context) {
    trips = AppCubit.get(context).trips;
    filteredTrips = trips;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is AppCreateFindsSuccessState){
          AppCubit.get(context).getTrips(dropOffLocation: state.dropOffLocation);
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                                    AppCubit.get(context).searchData(st: value);
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
                                  model: state is AppSearchResultsState
                                  ? state.searchResults[index]
                                      : AppCubit.get(context).trips[index],
                                  context: context,
                                  index: index,
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                              const SizedBox(
                                height: 20.0,
                              ),
                              itemCount: state is AppSearchResultsState
                                  ? state.searchResults.length
                                  : AppCubit.get(context).trips.length,
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
        );
      },
    );
  }
}
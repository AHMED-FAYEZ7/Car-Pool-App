import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/pages/confirm/confirm_page.dart';
import 'package:kau_carpool/pages/status/status_page.dart';
import 'package:kau_carpool/pages/wait/wait_page.dart';
import 'package:kau_carpool/widgets/default_appbar.dart';
import 'package:kau_carpool/widgets/rider_list_builder.dart';

class RiderRequestsPage extends StatelessWidget {
  RiderRequestsPage({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is AppCreateTripsSuccessState){
          AppCubit.get(context).getSelectedTrips(state.id);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: false,
          appBar: DefaultAppBar(
            title: "Rider Requests list",
          ),
          backgroundColor: ColorManager.backgroundColor,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
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
                                  onChanged: (value) {},
                                  textAlign: TextAlign.justify,
                                  decoration: const InputDecoration(
                                    hintText: "Search for a rider",
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            if(state is AppSelectedTripsUpdateState)
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Container(
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
                                                  '${AppCubit.get(context).selectTrip[index].rate}',
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
                                              '${AppCubit.get(context).selectTrip[index].name}',
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ConfirmPage(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/accept_ic.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => StatusPage(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/decline_ic.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 20.0,
                                ),
                                itemCount: cubit.selectTrip.length,
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
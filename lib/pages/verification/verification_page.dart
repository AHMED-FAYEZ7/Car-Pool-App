import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';
import 'package:kau_carpool/helper/app_prefs.dart';
import 'package:kau_carpool/helper/constant.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/layout/app_layout.dart';
import 'package:kau_carpool/pages/register/register_cubit/register_cubit.dart';
import 'package:kau_carpool/widgets/default_appbar.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myBloc = BlocProvider.of<RegisterCubit>(context);

    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context , state){
        // if(state is VerificationSuccess){
        //   RegisterCubit.get(context).updateIsEmailVerified(state.uId, state.isEmailVerified);
        // }
        if(state is VerificationTrue){
          CacheHelper.saveData(
            key: 'uId',
            value: state.uId,
          ).then((value) {
            uId = state.uId;
            AppCubit.get(context)
              ..getUserData()
              ..getAllUsers();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => AppLayout(),
                ), (route) {
              return false;
            });

          });
        }
      },
      builder: (context , state){
        return Scaffold(
          backgroundColor: ColorManager.backgroundColor,
          body: Column(
            children: [
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.only(
                  right: 50,
                  left: 50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "in less than a minute",
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorManager.blueWithOpacity,
                      ),
                    ),
                    const Image(
                      image: AssetImage("assets/images/verification.png"),
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
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
                      boxShadow: [BoxShadow(
                        offset: Offset.zero,
                        blurRadius: 20,
                        color: ColorManager.white,
                      ),
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 50
                    ),
                    child: Text(
                      'Please click the link sent to your email to verify\n your account and then login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorManager.blueWithOpacity,
                      ),
                    ),
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

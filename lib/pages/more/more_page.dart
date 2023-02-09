import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';
import 'package:kau_carpool/helper/constant.dart';
import 'package:kau_carpool/widgets/custom_button.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppState>(
        listener:(cintext ,state) {},
        builder:(cintext ,state) {
          return Column(
            children: [
              const SizedBox(height: 100,),
              Image.asset(
                  "assets/images/person_ic.png",
                scale: .7,
              ),
              SizedBox(height: 10,),
              Text(
                "$name",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "$phone",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10,),
              CustomButton(
                  text: 'Sign out',
                onTap: (){
                    AppCubit.get(context).signOut();
                },
              ),
            ],
          );
        },
    );
  }
}

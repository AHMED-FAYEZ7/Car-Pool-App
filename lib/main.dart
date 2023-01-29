import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/cubit/app_cubit.dart';
import 'package:kau_carpool/helper/app_prefs.dart';
import 'package:kau_carpool/helper/constant.dart';
import 'package:kau_carpool/layout/app_layout.dart';
import 'package:kau_carpool/pages/confirm/confirm_page.dart';
import 'package:kau_carpool/pages/home/home_page.dart';
import 'package:kau_carpool/pages/login/login_page.dart';
import 'package:kau_carpool/pages/register/register_page.dart';
import 'package:kau_carpool/pages/requests/requests_page.dart';
import 'package:kau_carpool/pages/verification/verification_page.dart';
import 'package:kau_carpool/pages/wait/wait_page.dart';
import 'bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await CacheHelper.init();
      Widget? widget;

      if(uId != null){
        widget = AppLayout();
      }else{
        widget = LoginPage();
      }


      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData()..getAllUsers()..getTrips(),
      child: BlocConsumer<AppCubit ,AppState>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            home: startWidget,
          );
        },
      ),
    );
  }
}

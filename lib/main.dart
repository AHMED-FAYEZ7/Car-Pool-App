import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/layout/app_layout.dart';
import 'package:kau_carpool/pages/login/login_page.dart';
import 'package:kau_carpool/pages/register/register_page.dart';
import 'bloc_observer.dart';
import 'firebase_options.dart';

void main() async{
  BlocOverrides.runZoned(() async
  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  },
      blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id : (context) => LoginPage(),
        RegisterPage.id : (context) => RegisterPage(),
        AppLayout.id : (context) => AppLayout(),
      },
      initialRoute: LoginPage.id,
    );
  }
}


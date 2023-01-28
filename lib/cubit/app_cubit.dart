import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/helper/app_prefs.dart';
import 'package:kau_carpool/helper/constant.dart';
import 'package:kau_carpool/models/offer_model.dart';
import 'package:kau_carpool/models/user_model.dart';
import 'package:kau_carpool/pages/home/home_page.dart';
import 'package:kau_carpool/pages/more/more_page.dart';
import 'package:kau_carpool/pages/trips/trips_page.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    HomePage(),
    TripsPage(),
    MorePage(),
  ];

  void changeBottomNav(int index)
  {
    // if(index == 1)
    // {
    //   getAllUsers();
    // }
      currentIndex = index;
      emit(AppChangeBottomNav());
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? userModel;

  void getUserData() async
   {
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
          userModel = UserModel.fromJson(value.data());
          CacheHelper.saveData(
            key: 'name',
            value: userModel!.name,
          ).then((value) {
            name = userModel!.name;
          });
      emit(AppGetUserSuccessState());
    })
        .catchError((error){
      print(error.toString());
      emit(AppGetUserErrorState(error.toString()));
    });
  }



  List<UserModel> users = [];

  void getAllUsers()
  {
    emit(AppGetAllUsersLoadingState());
    if(users.isEmpty)
    {
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
        for (var element in value.docs) {
          if(element.data()['uId'] != uId)
          {
            users.add(UserModel.fromJson(element.data()));
          }
        }
        emit(AppGetAllUsersSuccessState());
      })
          .catchError((error) {
        emit(AppGetAllUsersErrorState(error.toString()));
      });
    }
  }


  Future<void> createFindPool({
    required String dateTime,
    required String pickUpLocation,
    required String dropOffLocation,
  })async
  {
    emit(AppCreateOfferLoadingState());

    OfferModel model = OfferModel(
      uId: uId,
      name: name,
      dateTime: dateTime,
      pickUpLocation: pickUpLocation,
      dropOffLocation: dropOffLocation,
    );

    FirebaseFirestore.instance.collection('offers')
        .add(model.toMap())
        .then((value) {
      emit(AppCreateOfferSuccessState());
    })
        .catchError((error) {
      emit(AppCreateOfferErrorState());
    });
  }

  // home toggle
  int homeToggleIndex = 0;
  void homeToggleButton(int index)
  {
    if(index == 1)
    {
      homeToggleIndex = index;
      emit(OfferToggle());
    }else{
      homeToggleIndex = index;
      emit(FindToggle());
    }

  }

  // trips toggle
  int tripsToggleIndex = 0;
  void tripsToggleButton(int index)
  {
    if(index == 1)
    {
      tripsToggleIndex = index;
      emit(ScheduledTripsToggle());
    }else{
      tripsToggleIndex = index;
      emit(CurrentTripsToggle());
    }

  }
}

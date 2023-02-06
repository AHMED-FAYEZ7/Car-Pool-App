// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/helper/app_prefs.dart';
import 'package:kau_carpool/helper/constant.dart';
import 'package:kau_carpool/models/finds_model.dart';
import 'package:kau_carpool/models/trip_selectors_model.dart';
import 'package:kau_carpool/models/trips_model.dart';
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

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AppChangeBottomNav());
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  // To get user data
  UserModel? userModel;
  void getUserData() async {
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      CacheHelper.saveData(
        key: 'name',
        value: userModel!.name,
      ).then((value) {
        name = userModel!.name;
      });
      CacheHelper.saveData(
        key: 'phone',
        value: userModel!.phone,
      ).then((value) {
        phone = userModel!.phone;
      });
      CacheHelper.saveData(
        key: 'rate',
        value: userModel!.rate,
      ).then((value) {
        rate = userModel!.rate;
      });
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetUserErrorState(error.toString()));
    });
  }

  // To get all users data
  List<UserModel> users = [];
  void getAllUsers() {
    emit(AppGetAllUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        }
        emit(AppGetAllUsersSuccessState());
      }).catchError((error) {
        emit(AppGetAllUsersErrorState(error.toString()));
      });
    }
  }


  // To create new find pool to rider
  Future<void> createFindPool({
    required String dateTime,
    required String pickUpLocation,
    required String dropOffLocation,
  }) async {
    emit(AppCreateFindsLoadingState());

    FindModel model = FindModel(
      uId: uId,
      name: name,
      dateTime: dateTime,
      pickUpLocation: pickUpLocation,
      dropOffLocation: dropOffLocation,
    );

    FirebaseFirestore.instance
        .collection('finds')
        .add(model.toMap())
        .then((value) {
      emit(AppCreateFindsSuccessState(dropOffLocation));
    }).catchError((error) {
      emit(AppCreateFindsErrorState());
    });
  }

  // To create new offer pool or trip from driver
  Future<void> createOfferPool({
    required String dateTime,
    required String numberOfSeats,
    required String pickUpLocation,
    required String dropOffLocation,
  }) async {
    emit(AppCreateTripsLoadingState());

    TripsModel model = TripsModel(
      uId: uId,
      name: name,
      phone: phone,
      numberOfSeats: numberOfSeats,
      dateTime: dateTime,
      pickUpLocation: pickUpLocation,
      dropOffLocation: dropOffLocation,
    );

    FirebaseFirestore.instance
        .collection('trips')
        .add(model.toMap())
        .then((value) {
      emit(AppCreateTripsSuccessState(value.id));
    }).catchError((error) {
      emit(AppCreateTripsErrorState());
    });
  }

  List<TripsModel> trips = [];
  List<String> tripsId = [];
  List<int> selects = [];

  void getTrips({required String? dropOffLocation}) {
    emit(AppGetTripsLoadingState());
    FirebaseFirestore.instance.collection('trips')
        .where('dropOffLocation', isEqualTo: dropOffLocation).get().then((value) {
      trips = [];
      for (var element in value.docs) {
        element.reference.collection('selects').get().then((value) {
          selects.add(value.docs.length);
          tripsId.add(element.id);
          trips.add(TripsModel.fromJson(element.data()));
          emit(AppGetTripsSuccessState());
        }).catchError((error) {});
      }
    }).catchError((error) {
      emit(AppGetTripsErrorState(error.toString()));
    });
  }

  // To select trip
  void tripsSelects(String tripsId) async {
    try {
      await FirebaseFirestore.instance
          .collection('trips')
          .doc(tripsId)
          .collection('selectors')
          .doc(uId)
          .set({'name': name, 'rate': rate, 'selected': true});
      emit(AppSelectTripsSuccessState(tripsId));

    } catch (error) {
      emit(AppSelectTripsErrorState(error.toString()));
    }
  }

  List<SelectedTrip> selectTrip = [];
  List<String> selectTripsId = [];
  getSelectedTrips(String tripsId) async {

    FirebaseFirestore.instance
        .collection('trips')
        .doc(tripsId)
        .collection('selectors').snapshots().listen((event) {
          selectTrip = [];
          for (var element in event.docs) {
            selectTripsId.add(element.id);
            selectTrip.add(SelectedTrip.fromJson(element.data()));
            if (element.data()['status'] == 'accepted') {
              emit(AppSelectedTripsAcceptedState(element.id,tripsId));
            } else if (element.data()['status'] == 'refused') {
              emit(AppSelectedTripsRefusedState(element.id,tripsId));
            } else {
              emit(AppSelectedTripsUpdateState(element.id,tripsId));
            }
          }
    });
  }

  Future<void> acceptRequest(String selectorId, String tripId) async {
    await FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .collection('selectors')
        .doc(selectorId)
        .update({'status': 'accepted'});
  }

  Future<void> refuseRequest(String selectorId, String tripId) async {
    await FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .collection('selectors')
        .doc(selectorId)
        .update({'status': 'refused'});
  }


// home toggle
  int homeToggleIndex = 0;
  void homeToggleButton(int index) {
    if (index == 1) {
      homeToggleIndex = index;
      emit(OfferToggle());
    } else {
      homeToggleIndex = index;
      emit(FindToggle());
    }
  }

  // trips toggle
  int tripsToggleIndex = 0;
  void tripsToggleButton(int index) {
    if (index == 1) {
      tripsToggleIndex = index;
      emit(ScheduledTripsToggle());
    } else {
      tripsToggleIndex = index;
      emit(CurrentTripsToggle());
    }
  }
}
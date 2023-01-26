part of 'app_cubit.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class AppChangeBottomNav extends AppState {}

class FindToggle extends AppState {}
class OfferToggle extends AppState {}

class CurrentTripsToggle extends AppState {}
class ScheduledTripsToggle extends AppState {}

class AppGetUserLoadingState extends AppState {}
class AppGetUserSuccessState extends AppState {}
class AppGetUserErrorState extends AppState
{
  final String error;

  AppGetUserErrorState(this.error);
}

class AppGetAllUsersLoadingState extends AppState {}
class AppGetAllUsersSuccessState extends AppState {}
class AppGetAllUsersErrorState extends AppState
{
  final String error;

  AppGetAllUsersErrorState(this.error);
}

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

class AppCreateFindsLoadingState extends AppState {}
class AppCreateFindsSuccessState extends AppState {}
class AppCreateFindsErrorState extends AppState {}

class AppCreateTripsLoadingState extends AppState {}
class AppCreateTripsSuccessState extends AppState {}
class AppCreateTripsErrorState extends AppState {}

class AppGetTripsLoadingState extends AppState {}
class AppGetTripsSuccessState extends AppState {}
class AppGetTripsErrorState extends AppState
{
  final String error;

  AppGetTripsErrorState(this.error);
}

class AppSelectTripsSuccessState extends AppState {}
class AppSelectTripsErrorState extends AppState {
  final String error;

  AppSelectTripsErrorState(this.error);

}


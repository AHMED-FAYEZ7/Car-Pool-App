part of 'app_cubit.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class AppChangeBottomNav extends AppState {}
//////////////////////////////////////////////
class FindToggle extends AppState {}
class OfferToggle extends AppState {}
//////////////////////////////////////////////
class CurrentTripsToggle extends AppState {}
class ScheduledTripsToggle extends AppState {}
/////////////////////////////////////////////
class AppGetUserLoadingState extends AppState {}
class AppGetUserSuccessState extends AppState {}
class AppGetUserErrorState extends AppState
{
  final String error;

  AppGetUserErrorState(this.error);
}
///////////////////////////////////////////////////
class AppGetAllUsersLoadingState extends AppState {}
class AppGetAllUsersSuccessState extends AppState {}
class AppGetAllUsersErrorState extends AppState
{
  final String error;

  AppGetAllUsersErrorState(this.error);
}
//////////////////////////////////////////////
class AppCreateFindsLoadingState extends AppState {}
class AppCreateFindsSuccessState extends AppState {
  final String dropOffLocation;

  AppCreateFindsSuccessState(this.dropOffLocation);
}
class AppCreateFindsErrorState extends AppState {}
/////////////////////////////////////////////////
class AppCreateTripsLoadingState extends AppState {}
class AppCreateTripsSuccessState extends AppState {
  final String id;
  final List<TripsModel> myTrips;

  AppCreateTripsSuccessState(this.id,this.myTrips);
}
class AppCreateTripsErrorState extends AppState {}
////////////////////////////////////////////////
class AppGetTripsLoadingState extends AppState {}
class AppGetTripsSuccessState extends AppState {
  final List<TripsModel> trips;

  AppGetTripsSuccessState({required this.trips});
}
class AppGetTripsErrorState extends AppState {
  final String error;

  AppGetTripsErrorState(this.error);
}
//////////////////////////////////////////////////////
class AppSearchResultsState extends AppState {
  final List<TripsModel> searchResults;

  AppSearchResultsState({required this.searchResults});
}
//////////////////////////////////////////////////////////
class AppSelectedTripsLoadingUpdateState extends AppState {}
class AppSelectedTripsUpdateState extends AppState {
  final String id;
  final String tripId;

  AppSelectedTripsUpdateState(this.id,this.tripId);
}
class AppSelectedTripsAcceptedState extends AppState {
  final String id;
  final String tripId;

  AppSelectedTripsAcceptedState(this.id,this.tripId);
}
class AppSelectedTripsRefusedState extends AppState {
  final String id;
  final String tripId;

  AppSelectedTripsRefusedState(this.id,this.tripId);
}
//////////////////////////////////////////////////////
class AppSelectTripsSuccessState extends AppState {
  final String id;

  AppSelectTripsSuccessState(this.id);
}
class AppSelectTripsErrorState extends AppState {
  final String error;

  AppSelectTripsErrorState(this.error);

}
////////////////////////////////////////////////////
class AppGetAcceptedRidersUpdateState extends AppState {
  final List<SelectedTripModel> acceptedRiders;

  AppGetAcceptedRidersUpdateState(this.acceptedRiders );
}
////////////////////////////////
class AppGetMyAcceptedTripSuccessState extends AppState {}
class AppGetMyAcceptedTripErrorState extends AppState {}
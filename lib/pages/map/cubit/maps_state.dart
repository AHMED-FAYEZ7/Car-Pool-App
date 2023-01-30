part of 'maps_cubit.dart';

// return data from model
abstract class MapsState {}

class MapsInitial extends MapsState {}

class PlacesLoaded extends MapsState {
  // returned list of suggestion places

  final List<PlaceSuggestion> places;
  PlacesLoaded(this.places);
}

class PlaceLocationLoaded extends MapsState {
  // returned location
  final Place place;

  PlaceLocationLoaded(this.place);
}

class DirectionsLoaded extends MapsState {
  // return direction of current and destination
  final PlaceDirections placeDirections;

  DirectionsLoaded(this.placeDirections);
}

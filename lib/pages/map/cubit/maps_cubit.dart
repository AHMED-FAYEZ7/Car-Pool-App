import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kau_carpool/models/place.dart';
import 'package:kau_carpool/models/place_directions.dart';
import 'package:kau_carpool/models/place_suggestion.dart';
import 'package:kau_carpool/repository/maps_repo.dart';

part 'maps_state.dart';

// call api
class MapsCubit extends Cubit<MapsState> {
  final MapsRepository mapsRepository;

  MapsCubit(this.mapsRepository) : super(MapsInitial());
// func to call api to get suggestion (1 repo, 2 wepServices )
  void emitPlaceSuggestions(String place, String sessionToken) {
    mapsRepository.fetchSuggestions(place, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }
// func to call api to get PlaceLocation (1 repo, 2 wepServices )

  void emitPlaceLocation(String placeId, String sessionToken) {
    mapsRepository.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }

// take current location and destination position
  void emitPlaceDirections(LatLng origin, LatLng destination) {
    mapsRepository.getDirections(origin, destination).then((directions) {
      emit(DirectionsLoaded(directions));
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kau_carpool/models/place.dart';
import 'package:kau_carpool/models/place_directions.dart';
import 'package:kau_carpool/models/place_suggestion.dart';
import 'package:kau_carpool/repository/maps_repo.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapsRepository mapsRepository;

  MapsCubit(this.mapsRepository) : super(MapsInitial());

  void emitPlaceSuggestions(String place, String sessionToken) {
    mapsRepository.fetchSuggestions(place, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }

  void emitPlaceLocation(String placeId, String sessionToken) {
    mapsRepository.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }

  //    void emitPlaceDirections(LatLng origin, LatLng destination) {
  //   mapsRepository.getDirections(origin, destination).then((directions) {
  //     emit(DirectionsLoaded(directions));
  //   });
  // }
}

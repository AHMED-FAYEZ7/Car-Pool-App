import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kau_carpool/helper/places_webservices.dart';
import 'package:kau_carpool/models/place.dart';
import 'package:kau_carpool/models/place_directions.dart';
import 'package:kau_carpool/models/place_suggestion.dart';

// layer between wepServices and model
// map data come from api to use it with cubit and model
class MapsRepository {
  final PlacesWebservices placesWebservices;

  MapsRepository(this.placesWebservices);

  Future<List<PlaceSuggestion>> fetchSuggestions(
    String place,
    String sessionToken,
  ) async {
    // save data come from api
    final suggestions = await placesWebservices.fetchSuggestions(
      place,
      sessionToken,
    );
// map data come from api to be acceptable and save it in model
    return suggestions
        .map(
          (suggestion) => PlaceSuggestion.fromJson(suggestion),
        )
        .toList();
  }

  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    // save data come from api
    final place = await placesWebservices.getPlaceLocation(
      placeId,
      sessionToken,
    );

    // var readyPlace = Place.fromJson(place);
    return Place.fromJson(place);
  }

  Future<PlaceDirections> getDirections(
    LatLng origin,
    LatLng destination,
  ) async {
    final directions = await placesWebservices.getDirections(
      origin,
      destination,
    );

    return PlaceDirections.fromJson(directions);
  }
}

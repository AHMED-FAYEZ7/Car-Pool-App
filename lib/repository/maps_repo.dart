import 'package:kau_carpool/helper/places_webservices.dart';
import 'package:kau_carpool/models/place.dart';
import 'package:kau_carpool/models/place_suggestion.dart';

class MapsRepository {
  final PlacesWebservices placesWebservices;

  MapsRepository(this.placesWebservices);

  Future<List<PlaceSuggestion>> fetchSuggestions(
    String place,
    String sessionToken,
  ) async {
    final suggestions =
        await placesWebservices.fetchSuggestions(place, sessionToken);

    return suggestions
        .map((suggestion) => PlaceSuggestion.fromJson(suggestion))
        .toList();
  }

  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    final place =
        await placesWebservices.getPlaceLocation(placeId, sessionToken);
    // var readyPlace = Place.fromJson(place);
    return Place.fromJson(place);
  }

  // Future<PlaceDirections> getDirections(
  //     LatLng origin, LatLng destination) async {
  //   final directions =
  //       await placesWebservices.getDirections(origin, destination);

  //   return PlaceDirections.fromJson(directions);
  // }
}

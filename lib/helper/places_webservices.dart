// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:kau_carpool/constants.dart';

// use it to call api

class PlacesWebservices {
  late Dio dio;

  PlacesWebservices() {
    BaseOptions options = BaseOptions(
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  static Future<String> getAddressFromCoordinates(
    double lat,
    double lng,
  ) async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        addressBaseUrl,
        queryParameters: {
          'latlng': '${lat},${lng}',
          'key': googleAPIKey,
        },
      );
      List<dynamic> address = response.data["results"][0]["address_components"];
      String addressString = "";
      for (int i = 0; i < address.length; i++) {
        addressString += "${address[i]["long_name"]}, ";
      }
      return addressString.substring(0, addressString.length - 2);
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }
}

// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kau_carpool/helper/app_prefs.dart';

String? uId = CacheHelper.getData(key: 'uId');
String? name = CacheHelper.getData(key: 'name');
double rate = CacheHelper.getData(key: 'rete');

double? StartLat = CacheHelper.getData(key: 'startLat');
double? StartLng = CacheHelper.getData(key: 'startLng');
double? EndLat = CacheHelper.getData(key: 'endLat');
double? EndLng = CacheHelper.getData(key: 'endLng');

String? phone = CacheHelper.getData(key: 'phone');

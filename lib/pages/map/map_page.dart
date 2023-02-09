import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kau_carpool/constants.dart';
import 'package:kau_carpool/helper/location_helper.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/widgets/default_appbar.dart';
import 'package:kau_carpool/widgets/map_utils.dart';

class MapPage extends StatefulWidget {
  final double? startLat;
  final double? startLng;
  final double? endLat;
  final double? endLng;
  MapPage({
    super.key,
    this.startLat,
    this.startLng,
    this.endLat,
    this.endLng,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late CameraPosition _cameraPosition;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  static Position? position;

  @override
  initState() {
    super.initState();
    getMyCurrentLocation();
    _cameraPosition = CameraPosition(
      target: LatLng(
        widget.startLat!,
        widget.startLng!,
      ),
      zoom: 13,
    );
  }

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {});

    setState(() {});
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(
        widget.startLat!,
        widget.startLng!,
      ),
      PointLatLng(
        widget.endLat!,
        widget.endLng!,
      ),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      });
    }
    _addPolyLine();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(
        markerId: MarkerId("start"),
        position: LatLng(
          widget.startLat!,
          widget.startLng!,
        ),
        // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      ),
      Marker(
        markerId: MarkerId("end"),
        position: LatLng(
          widget.endLat!,
          widget.endLng!,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    };

    return Scaffold(
      appBar: DefaultAppBar(title: "Track your Trip"),
      body: position == null
          ? Center(
              child: Container(
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                ),
              ),
            )
          : GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _cameraPosition,
              markers: _markers,
              //  {
              //   Marker(
              //     markerId: MarkerId("current location"),
              //     position: LatLng(
              //       position!.latitude,
              //       position!.longitude,
              //     ),
              //     icon: BitmapDescriptor.defaultMarkerWithHue(
              //         BitmapDescriptor.hueAzure),
              //   ),
              //   Marker(
              //     markerId: MarkerId("start"),
              //     position: LatLng(
              //       widget.startLat!,
              //       widget.startLng!,
              //     ),
              //     // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
              //   ),
              //   Marker(
              //     markerId: MarkerId("end"),
              //     position: LatLng(
              //       widget.endLat!,
              //       widget.endLng!,
              //     ),
              //     icon: BitmapDescriptor.defaultMarkerWithHue(
              //         BitmapDescriptor.hueBlue),
              //   ),
              // },

              onMapCreated: (GoogleMapController controller) {
                Future.delayed(Duration(milliseconds: 2000), () {
                  controller.animateCamera(CameraUpdate.newLatLngBounds(
                      MapUtils.boundsFromLatLngList(
                        _markers.map((loc) => loc.position).toList(),
                      ),
                      1));
                  _getPolyline();
                });
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }
}

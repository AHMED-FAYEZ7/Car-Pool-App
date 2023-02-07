import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kau_carpool/constants.dart';
import 'package:kau_carpool/widgets/default_appbar.dart';
import 'package:kau_carpool/widgets/map_utils.dart';

class MapPage extends StatefulWidget {
  final double? startLat;
  final double? startLng;
  final double? endLat;
  final double? endLng;
  MapPage({
    super.key,
    required this.startLat,
    required this.startLng,
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
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  @override
  initState() {
    super.initState();

    _cameraPosition = CameraPosition(
      target: LatLng(
        widget.startLat!,
        widget.startLng!,
      ),
      zoom: 13,
    );
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
      ),
      Marker(
        markerId: MarkerId("end"),
        position: LatLng(
          widget.endLat!,
          widget.endLng!,
        ),
      ),
    };

    return Scaffold(
      appBar: DefaultAppBar(title: "title"),
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        initialCameraPosition: _cameraPosition,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          Future.delayed(Duration(milliseconds: 2000), () {
            controller.animateCamera(CameraUpdate.newLatLngBounds(
                MapUtils.boundsFromLatLngList(
                    _markers.map((loc) => loc.position).toList()),
                1));
            _getPolyline();
          });
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }
}

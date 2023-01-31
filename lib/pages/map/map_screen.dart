// ignore_for_file: avoid_print, unnecessary_string_interpolations, prefer_collection_literals, prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kau_carpool/helper/app_prefs.dart';
import 'package:kau_carpool/helper/constant.dart';
import 'package:kau_carpool/helper/location_helper.dart';
import 'package:kau_carpool/helper/resources/color_manager.dart';
import 'package:kau_carpool/models/place.dart';
import 'package:kau_carpool/models/place_directions.dart';
import 'package:kau_carpool/models/place_suggestion.dart';
import 'package:kau_carpool/pages/map/cubit/maps_cubit.dart';
import 'package:kau_carpool/widgets/default_appbar.dart';
import 'package:kau_carpool/widgets/distance_and_time.dart';
import 'package:kau_carpool/widgets/place_item.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:uuid/uuid.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);
  static String id = 'MapScreen';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // list to store searched places
  List<PlaceSuggestion> places = [];

// object to store position lat & lng
  static Position? position;

// controller of map widget
  final Completer<GoogleMapController> _mapController = Completer();

  // controller of search bar widget
  FloatingSearchBarController controller = FloatingSearchBarController();

  // camera position to track current location
  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    // pass current position lat & lng
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );

  // these variables for Get Place Location
  Set<Marker> markers = Set();
  late PlaceSuggestion placeSuggestion;
  late Place selectedPlace;
  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;
  late CameraPosition goToSearchedForPlace;

  // these variables for Get Directions
  PlaceDirections? placeDirections;
  var progressIndicator = false;
  late List<LatLng> polylinePoints;
  var isSearchedPlaceMarkerClicked = false;
  var isTimeAndDistanceVisible = false;
  late String time;
  late String distance;

// move camera position to the searched place
  void buildCameraNewPosition() {
    goToSearchedForPlace = CameraPosition(
      bearing: 0.0,
      tilt: 0.0,
      target: LatLng(
        selectedPlace.result.geometry.location.lat,
        selectedPlace.result.geometry.location.lng,
      ),
      zoom: 20,
    );
  }

  @override
  initState() {
    super.initState();

    getMyCurrentLocation();
  }

// get current location (from LOCATION HELPER) of user & save it
  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {});
    double lat = position!.latitude;
    double long = position!.longitude;
    print(position!.latitude);
    //  save current location to reuse it
    CacheHelper.saveData(key: "cLat1", value: lat).then((value) {
      cLat1 = lat;
    });
    CacheHelper.saveData(key: "cLong1", value: long).then((value) {
      cLong1 = long;
    });

    setState(() {});
  }

// google map widget
  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      mapType: MapType.satellite,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      markers: markers,
      polylines: placeDirections != null
          ? {
              Polyline(
                polylineId: const PolylineId('my_polyline'),
                color: Colors.black,
                width: 2,
                points: polylinePoints,
              ),
            }
          : {},
    );
  }

// use it to go for current location
  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        _myCurrentLocationCameraPosition,
      ),
    );
  }

// search bar
  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: controller,
      elevation: 6,
      hintStyle: const TextStyle(fontSize: 18),
      queryStyle: const TextStyle(fontSize: 18),
      hint: 'Find a place..',
      border: const BorderSide(style: BorderStyle.none),
      margins: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: 52,
      iconColor: ColorManager.primary,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      progress: progressIndicator,
      onQueryChanged: (query) {
        // detect each latter add and give suggestion
        getPlacesSuggestions(query);
      },
      onFocusChanged: (_) {
        // hide distance and time containers
        setState(() {
          // when place selected remove time and distance
          isTimeAndDistanceVisible = false;
        });
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
            onPressed: () {},
          ),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // fetch all suggested places
              buildSuggestionsBloc(),
              // build destination location
              buildSelectedPlaceLocationBloc(),
              // build track between current location and destination
              buildDiretionsBloc(),
            ],
          ),
        );
      },
    );
  }

//  store direction come from api
  Widget buildDiretionsBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is DirectionsLoaded) {
          placeDirections = (state).placeDirections;

          getPolylinePoints();
        }
      },
      child: Container(),
    );
  }

// save points of current and destination from api
  void getPolylinePoints() {
    polylinePoints = placeDirections!.polylinePoints
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
  }

// selected place bloc
  Widget buildSelectedPlaceLocationBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceLocationLoaded) {
          // save result of selected place from list (api) to use it in google widget
          selectedPlace = (state).place;
          // save position of selected place
          CacheHelper.saveData(
            key: "dLong1",
            value: selectedPlace.result.geometry.location.lng,
          ).then((value) {
            dLong1 = selectedPlace.result.geometry.location.lng;
          });
          CacheHelper.saveData(
            key: "dLat1",
            value: selectedPlace.result.geometry.location.lat,
          ).then((value) {
            dLat1 = selectedPlace.result.geometry.location.lat;
          });
          CacheHelper.saveData(
            key: "address",
            value: placeSuggestion.description,
          ).then((value) {
            address = placeSuggestion.description;
          });

          goToMySearchedForLocation();
          getDirections();
        }
      },
      child: Container(),
    );
  }

// call api of direction give it current location and destination
  void getDirections() {
    BlocProvider.of<MapsCubit>(context).emitPlaceDirections(
      LatLng(position!.latitude, position!.longitude),
      LatLng(
        selectedPlace.result.geometry.location.lat,
        selectedPlace.result.geometry.location.lng,
      ),
    );
  }

// move camera to selected place and build marker
  Future<void> goToMySearchedForLocation() async {
    buildCameraNewPosition();
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(goToSearchedForPlace),
    );
    buildSearchedPlaceMarker();
  }

  void buildSearchedPlaceMarker() {
    searchedPlaceMarker = Marker(
      position: goToSearchedForPlace.target,
      markerId: const MarkerId('1'),
      onTap: () {
        // on tap build marker of current location
        buildCurrentLocationMarker();
        // show time and distance
        setState(() {
          isSearchedPlaceMarkerClicked = true;
          isTimeAndDistanceVisible = true;
        });
      },
      infoWindow: InfoWindow(title: "${placeSuggestion.description}"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
  }

  void buildCurrentLocationMarker() {
    currentLocationMarker = Marker(
      position: LatLng(position!.latitude, position!.longitude),
      markerId: const MarkerId('2'),
      onTap: () {},
      infoWindow: const InfoWindow(title: "Your current Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    addMarkerToMarkersAndUpdateUI(currentLocationMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }

// suggested places
  void getPlacesSuggestions(String query) {
    final sessionToken = Uuid().v4();
    BlocProvider.of<MapsCubit>(context).emitPlaceSuggestions(
      query,
      sessionToken,
    );
  }

// build ui of suggestion places
  Widget buildSuggestionsBloc() {
    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          // save places come from api in placesList to use it in ui
          places = (state).places;
          if (places.length != 0) {
            return buildPlacesList();
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

// places ui
  Widget buildPlacesList() {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return InkWell(
          onTap: () async {
            // save placeId to be used in calling API
            placeSuggestion = places[index];
            controller.close();
            // go to selected place
            getSelectedPlaceLocation();
            // remove track
            polylinePoints.clear();
            // remove marker
            removeAllMarkersAndUpdateUI();
          },
          child: PlaceItem(
            suggestion: places[index],
          ),
        );
      },
      itemCount: places.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }

  void removeAllMarkersAndUpdateUI() {
    setState(() {
      markers.clear();
    });
  }

// call api for place location
  void getSelectedPlaceLocation() {
    final sessionToken = Uuid().v4();
    BlocProvider.of<MapsCubit>(context).emitPlaceLocation(
      // stored from places[index]
      placeSuggestion.placeId,
      sessionToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: DefaultAppBar(
        title: "Map",
      ),
      backgroundColor: ColorManager.backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? buildMap()
              : Center(
                  child: Container(
                    child: CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  ),
                ),
          buildFloatingSearchBar(),
          isSearchedPlaceMarkerClicked
              ? DistanceAndTime(
                  isTimeAndDistanceVisible: isTimeAndDistanceVisible,
                  placeDirections: placeDirections,
                )
              : Container(),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: const EdgeInsets.fromLTRB(70, 15, 3, 60),
          child: FloatingActionButton(
            backgroundColor: ColorManager.primary,
            onPressed: _goToMyCurrentLocation,
            child: Icon(
              Icons.place,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }
}

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
import 'package:kau_carpool/models/place_suggestion.dart';
import 'package:kau_carpool/pages/map/cubit/maps_cubit.dart';
import 'package:kau_carpool/widgets/default_appbar.dart';
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
  List<PlaceSuggestion> places = [];

  static Position? position;
  final Completer<GoogleMapController> _mapController = Completer();
  FloatingSearchBarController controller = FloatingSearchBarController();
  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );

  // these variables for getPlaceLocation
  Set<Marker> markers = Set();
  late PlaceSuggestion placeSuggestion;
  late Place selectedPlace;
  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;
  late CameraPosition goToSearchedForPlace;

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

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {});
    print("${position!.latitude}, ${position!.longitude} yyyyyyyyyyy");
    double lat = position!.latitude;
    double long = position!.longitude;
    CacheHelper.saveData(key: "cLat1", value: lat).then((value) {
      cLat1 = lat;
    });
    CacheHelper.saveData(key: "cLong1", value: long).then((value) {
      cLong1 = long;
    });

    setState(() {});
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      markers: markers,
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition),
    );
    print("${position!.latitude}, ${position!.longitude} ssssssssssss");
    // CacheHelper.saveData(key: "position", value: lat).then((value) {
    //   pos = position.toString();
    // });
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: controller,
      elevation: 6,
      hintStyle: TextStyle(fontSize: 18),
      queryStyle: TextStyle(fontSize: 18),
      hint: 'Find a place..',
      border: BorderSide(style: BorderStyle.none),
      margins: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
      // progress: progressIndicator,
      onQueryChanged: (query) {
        getPlacesSuggestions(query);
      },
      // onFocusChanged: (_) {
      //   // hide distance and time row
      //   setState(() {
      //     isTimeAndDistanceVisible = false;
      //   });
      // },
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
              buildSuggestionsBloc(),
              buildSelectedPlaceLocationBloc(),
              // buildDiretionsBloc(),
            ],
          ),
        );
      },
    );
  }

  Widget buildSelectedPlaceLocationBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceLocationLoaded) {
          selectedPlace = (state).place;
          print("${selectedPlace.result.geometry.location.lat} mmmmmmmmmmm");
          print("${selectedPlace.result.geometry.location.lng} xxxxxxxxxxxxxx");
          print("${placeSuggestion.description} xxxxxxxxxxxxxx");
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
          // getDirections();
        }
      },
      child: Container(),
    );
  }

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
      markerId: MarkerId('1'),
      onTap: () {
        buildCurrentLocationMarker();
        // show time and distance
        // setState(() {
        //   // isSearchedPlaceMarkerClicked = true;
        //   // isTimeAndDistanceVisible = true;
        // });
      },
      infoWindow: InfoWindow(title: "${placeSuggestion.description}"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
  }

  void buildCurrentLocationMarker() {
    currentLocationMarker = Marker(
      position: LatLng(position!.latitude, position!.longitude),
      markerId: MarkerId('2'),
      onTap: () {},
      infoWindow: InfoWindow(title: "Your current Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    addMarkerToMarkersAndUpdateUI(currentLocationMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }

  void getPlacesSuggestions(String query) {
    final sessionToken = Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceSuggestions(query, sessionToken);
  }

  Widget buildSuggestionsBloc() {
    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
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

  Widget buildPlacesList() {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return InkWell(
          onTap: () async {
            placeSuggestion = places[index];
            controller.close();
            getSelectedPlaceLocation();
            // polylinePoints.clear();
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

  void getSelectedPlaceLocation() {
    final sessionToken = Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceLocation(placeSuggestion.placeId, sessionToken);
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
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: EdgeInsets.fromLTRB(55, 15, 3, 0),
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

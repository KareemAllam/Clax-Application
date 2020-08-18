// Dart & Other Pacakges
import 'dart:math';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Flutter Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/CurrentTrip.dart';
// Providers
import 'package:clax/providers/Map.dart';
import 'package:clax/providers/CurrentTrip.dart';
// Components
import 'package:clax/screens/MakeARide/Components/DriverInfo.dart';
// Services
import 'package:clax/services/GoogleApi.dart';
// Map Utils
import 'package:clax/utils/MapConversions.dart';

class MapPage extends StatefulWidget {
  static const routeName = "map";
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapProvider map;
  bool built = false;

  Future createPolyLine(GoogleMapController controller) async {
    CurrentTrip currentTripInfo =
        Provider.of<CurrentTripProvider>(context, listen: false)
            .currentTripInfo;
    Map result =
        await getLinePoints(currentTripInfo.start, currentTripInfo.end);
    if (!result['status']) return;
    List<Point<num>> _polyLine = result['polyline'];
    List<LatLng> polylinePoints =
        MapConversions.stringPointToLatLngs(_polyLine);
    map.polylines.add(
      Polyline(
        polylineId: PolylineId('dynamic'),
        visible: true,
        startCap: Cap.roundCap,
        geodesic: true,
        jointType: JointType.round,
        endCap: Cap.roundCap,
        points: polylinePoints,
        width: 2,
        color: Colors.purple,
      ),
    );
    setState(() {});
    controller.getZoomLevel().then(
          (zoomLevel) => controller.animateCamera(
              CameraUpdate.newLatLng(currentTripInfo.pickupCoords)),
        );
  }

  @override
  void dispose() {
    map.disposeInit();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    map = Provider.of<MapProvider>(context);
  }

  void showInfo(BuildContext contx) async {
    showModalBottomSheet<void>(
        enableDrag: true,
        context: contx,
        builder: (BuildContext context) {
          return DriverInfo();
        });
  }

  @override
  Widget build(BuildContext context) {
    if (!built) {
      map.checkPermission();
      built = true;
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.gps_fixed),
              onPressed: () async {
                try {
                  map.focusDriver = false;
                  map.navigateToUser();
                } catch (_) {
                  map.navigateToUser();
                }
              }),
          IconButton(
              icon: const Icon(
                Icons.directions_bus,
                color: Colors.white,
              ),
              onPressed: () {
                map.focusDriver = true;
                map.navigateToDriver();
              }),
          Builder(
            builder: (contx) => IconButton(
                icon: const Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                onPressed: () {
                  showInfo(contx);
                }),
          )
        ],
        title: Text(
          "تابع رحلتك",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              scrollGesturesEnabled: false,
              tiltGesturesEnabled: false,
              compassEnabled: true,
              zoomGesturesEnabled: true,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              indoorViewEnabled: false,
              onCameraMove: null,
              zoomControlsEnabled: false,
              circles: map.circles,
              polylines: map.polylines,
              markers: map.markers.values.toSet(),
              cameraTargetBounds: CameraTargetBounds(
                LatLngBounds(
                    southwest: LatLng(25.78847, 25.00192),
                    northeast: LatLng(40.78847, 40.00192)),
              ),
              minMaxZoomPreference: MinMaxZoomPreference(12, 25),
              initialCameraPosition: CameraPosition(
                  target: map.coordinates ?? LatLng(31.5812, 30.50037),
                  zoom: 14),
              onMapCreated: (GoogleMapController controller) {
                createPolyLine(controller);
                map.controller.complete(controller);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  color: Theme.of(context).primaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Text(
                        map.timeString ?? "loading",
                        textAlign: TextAlign.center,
                        strutStyle: StrutStyle(forceStrutHeight: true),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        map.distanceString ?? "loading",
                        textAlign: TextAlign.center,
                        strutStyle: StrutStyle(forceStrutHeight: true),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        map.name,
                        textAlign: TextAlign.center,
                        strutStyle: StrutStyle(forceStrutHeight: true),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

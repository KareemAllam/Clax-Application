// Dart & Other Pacakges
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Flutter Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Map.dart';
// Components
import 'package:clax/screens/MakeARide/Components/DriverInfo.dart';
// Map Styles
import 'package:clax/mapstyles.dart';

class MapPage extends StatefulWidget {
  static const routeName = "map";
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapProvider map;
  bool built = false;
  @override
  void dispose() {
    map.disposeInit();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
              cameraTargetBounds: CameraTargetBounds(LatLngBounds(
                  southwest: LatLng(25.78847, 25.00192),
                  northeast: LatLng(40.78847, 40.00192))),
              minMaxZoomPreference: MinMaxZoomPreference(7, 25),
              initialCameraPosition: CameraPosition(
                  target: map.coordinates ?? LatLng(31.5812, 30.50037),
                  zoom: 12),
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(uber);
                if (!map.controller.isCompleted)
                  map.controller.complete(controller);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: map.gpsEnabled
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          Text(
                            map.name,
                            textAlign: TextAlign.center,
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: Colors.white,
                                    fontFamily: "Product Sans"),
                          ),
                          Text(
                            '${map.distance}',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: Colors.white,
                                    fontFamily: "Product Sans"),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_on,
                              color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "فعل نظام الملاحه الخاص بك",
                            textAlign: TextAlign.center,
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(color: Colors.white),
                          )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

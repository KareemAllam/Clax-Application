import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/Map.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int seats = 0;
  CustomMap map;

  @override
  void initState() {
    super.initState();
    map = CustomMap(scaffoldKey: _scaffoldKey, inZoom: 10);
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Google Maps"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.map), onPressed: map.checkPermission),
          IconButton(
            icon: Icon(Icons.local_car_wash),
            onPressed: () {
              map.enableStreamingCurrentLocation("driver123", seats, () {
                setState(() {});
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.drive_eta),
            onPressed: () {
              map.disableStreamingCurrentLocation();
            },
          ),
          IconButton(
            icon: Icon(Icons.gps_not_fixed),
            onPressed: () {
              map.enableStreamingDriverLocation("driver123", () {
                setState(() {});
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.gps_off),
            onPressed: () {
              map.disableStreamingDriverLocation("driver123");
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            polylines: map.polylines,
            markers: map.markers.values.toSet(),
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: LatLng(40, 40), zoom: map.zooming),
            onMapCreated: (GoogleMapController controller) {
              map.controller.complete(controller);
            },
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 10, left: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    // check if seats are full
                    if (seats <= 11)
                      setState(() {
                        seats++;
                      });
                    // else return
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                ),
                Text(seats.toString(),
                    strutStyle: StrutStyle(forceStrutHeight: true),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black)),
                IconButton(
                    onPressed: () {
                      // check if seats are empty
                      if (seats >= 1)
                        setState(() {
                          seats--;
                        });
                      // else return
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

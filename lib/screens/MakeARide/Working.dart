// Dart & Other Packages
import 'package:clax/screens/Drawer.dart';
import 'package:clax/screens/MakeARide/Components/PassengersInfo.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Tracking.dart';
// Components
import 'package:clax/screens/MakeARide/Components/Seats.dart';
import 'package:clax/screens/MakeARide/Components/GeolocationPermissionsRetry.dart';

class Working extends StatefulWidget {
  static const routeName = '/working';

  @override
  _WorkingState createState() => _WorkingState();
}

class _WorkingState extends State<Working> {
  // ----- Screen Vars -----
  // Map Vars
  GoogleMapController mapController;
  TrackingProvider tracking;

  // Driver Vars
  String driverId;
  // Theme Vars
  ThemeData theme;
  // Permissions
  GeolocationStatus permission;
  bool gpsEnabled;
  bool allGood;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    tracking = Provider.of<TrackingProvider>(context);
    theme = Theme.of(context);
    permission = tracking.permission;
    gpsEnabled = tracking.gpsEnabled;
    if (gpsEnabled == null || permission != GeolocationStatus.granted) {
      await tracking.checkServiceState();
    } else
      allGood = true;
  }

  @override
  void dispose() {
    super.dispose();
    // tracking.disableStreamingCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    // Current Line as Screen Title
    Map<String, String> result =
        Map<String, String>.from(ModalRoute.of(context).settings.arguments);
    String lineName = result['lineName'];

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // leading: SizedBox(),
        actions: <Widget>[
          // Debugging & Testing  UI
          // IconButton(
          //     icon: Icon(Icons.play_arrow),
          //     onPressed: () {
          //       tracking.enableStreamingCurrentLocation();
          //     }),
          // IconButton(
          //     icon: Icon(Icons.stop),
          //     onPressed: () {
          //       tracking.disableStreamingCurrentLocation();
          //     })
        ],
        title: Text(lineName,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      drawer: MainDrawer(),
      body: WillPopScope(
          child: allGood == null
              ? Center(
                  child: IntrinsicHeight(
                    child: IntrinsicWidth(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(20),
                        child: SpinKitCircle(color: theme.primaryColor),
                      ),
                    ),
                  ),
                )
              : gpsEnabled
                  ? Stack(
                      children: <Widget>[
                        Builder(
                          builder: (context) => GoogleMap(
                            polylines: tracking.polylines.values.toSet(),
                            markers: tracking.markers.values.toSet(),
                            compassEnabled: false,
                            zoomControlsEnabled: false,
                            // onCameraMoveStarted: () =>
                            //     Provider.of<TrackingProvider>(context,
                            //             listen: false)
                            //         .driverFocued = false,
                            minMaxZoomPreference: MinMaxZoomPreference(10, 20),
                            onMapCreated: (GoogleMapController controller) {
                              tracking.controller = controller;
                              tracking.enableStreamingCurrentLocation();
                            },
                            initialCameraPosition: CameraPosition(
                              target: LatLng(30.29448, 30.5486),
                              zoom: 12.0,
                            ),
                            mapType: MapType.normal,
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: FloatingActionButton(
                            heroTag: "locateMe",
                            mini: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 0,
                            highlightElevation: 0,
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            onPressed: () async {
                              Provider.of<TrackingProvider>(context,
                                      listen: false)
                                  .driverFocued = true;
                              await Provider.of<TrackingProvider>(context,
                                      listen: false)
                                  .navigatorToDriver();
                            },
                            child: Icon(Icons.gps_fixed),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 56,
                          child: FloatingActionButton(
                            heroTag: "showUsers",
                            mini: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 0,
                            highlightElevation: 0,
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.transparent,
                                builder: (context) => PassengersInfo(),
                              );
                            },
                            child: Icon(
                              Icons.person_pin_circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Seats(),
                      ],
                    )
                  : RetryPermission(),
          onWillPop: () async => false),
    );
  }
}

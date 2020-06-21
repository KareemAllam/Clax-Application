// Dart & Other Packages
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
  final Function changeState;
  Working(this.changeState);
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tracking = Provider.of<TrackingProvider>(context);
    theme = Theme.of(context);
    permission = tracking.permission;
    gpsEnabled = tracking.gpsEnabled;
  }

  @override
  void dispose() {
    super.dispose();
    tracking.disableStreamingCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    bool geolocatingEnabled = false;
    bool loadingVars = (gpsEnabled == null || permission == null);
    if (!loadingVars)
      geolocatingEnabled =
          (permission == GeolocationStatus.granted && gpsEnabled);
    return loadingVars
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
        : geolocatingEnabled
            ? Stack(
                children: <Widget>[
                  GoogleMap(
                    polylines: tracking.polylines.values.toSet(),
                    markers: tracking.markers.values.toSet(),
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    onCameraMoveStarted: () =>
                        Provider.of<TrackingProvider>(context, listen: false)
                            .driverFocued = false,
                    minMaxZoomPreference: MinMaxZoomPreference(10, 15),
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
                        Provider.of<TrackingProvider>(context, listen: false)
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
                    right: 72,
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
            : RetryPermission();
  }
}

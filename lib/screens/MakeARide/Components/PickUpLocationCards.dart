// Dart & Other Packages
import 'package:clax/screens/MakeARide/MapPickLocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Line.dart';
// Providers
import 'package:clax/providers/Map.dart';
// Widgets
import 'package:clax/widgets/Cards.dart';
import 'package:clax/screens/MakeARide/widgets/StationCard.dart';

class PickUpLocation extends StatefulWidget {
  final LineModel line;
  final Function setPickUpLodation;
  PickUpLocation({this.line, this.setPickUpLodation});

  @override
  _PickUpLocationState createState() => _PickUpLocationState();
}

class _PickUpLocationState extends State<PickUpLocation> {
  // Theme Vars
  ThemeData theme;
  // Swtiching Vars
  int methSelected = 0;
  List<Widget> methods = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    methods = [
      pickupMethods(),
      Text("asd"),
      GpsLocation(
          cancelMethod: () => setState(() => methSelected = 0),
          line: widget.line,
          updatePickUpLodation: widget.setPickUpLodation),
      stationsList()
    ];
  }

  // Pick a method Widget
  Widget pickupMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(16),
            child: Text("حدد مكان الركوب:",
                strutStyle: StrutStyle(forceStrutHeight: true),
                style: theme.textTheme.bodyText1.copyWith(color: Colors.grey))),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Cards.horizontalListTile(context,
                  icon: Icons.gps_fixed,
                  title: "اختار من الخريطه", tapHandler: () {
                Navigator.of(context)
                    .pushNamed(MapPickLocation.routeName, arguments: {
                  "start":LatLng.fromJson(widget.line.stations[0].coordinates),
                  "end": LatLng.fromJson(widget.line.stations.last.coordinates),
                  "stations": widget.line.stations
                }).then((value) {
                  print(value);
                  Map result = value as Map<String, dynamic>;
                  if (result != null && result.length > 0) {
                    widget.setPickUpLodation(
                        result['name'], result['location'], Icons.gps_fixed);
                  }
                });
              }),
              Cards.horizontalListTile(context,
                  icon: Icons.pin_drop,
                  title: "اختار مكانك الحالى",
                  tapHandler: () => setState(() => methSelected = 2)),
              Cards.horizontalListTile(context,
                  icon: Icons.subway,
                  title: "اختار محطة على الخط", tapHandler: () {
                setState(() => methSelected = 3);
              }),
            ])
      ],
    );
  }

  // Method: Pick from Stations
  Widget stationsList() {
    dynamic position(int index) {
      if (index == 0)
        return false;
      else if (index == widget.line.stations.length - 1)
        return true;
      else
        return null;
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.linear_scale, color: theme.primaryColor),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${widget.line.from} - ${widget.line.to}',
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: theme.textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "من محافظة الى محافظة",
                          style: theme.textTheme.subtitle2
                              .copyWith(color: Colors.grey),
                          strutStyle: StrutStyle(forceStrutHeight: true),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      setState(() => methSelected = 0);
                    })
              ],
            )),
        Expanded(
          child: ListView.builder(
              itemCount: widget.line.stations.length,
              itemExtent: 50,
              controller: ScrollController(),
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemBuilder: (context, index) => StationCard(
                  position: position(index),
                  station: widget.line.stations[index],
                  onSelect: widget.setPickUpLodation)),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: methods[methSelected]);
  }
}

class GpsLocation extends StatefulWidget {
  final Function cancelMethod;
  final LineModel line;
  final Function updatePickUpLodation;
  GpsLocation({this.cancelMethod, this.line, this.updatePickUpLodation});
  @override
  _GpsLocationState createState() => _GpsLocationState();
}

class _GpsLocationState extends State<GpsLocation> {
  bool loading = true;
  bool gpsEnabled = false;
  Future retreiveLocation() async {
    setState(() {
      loading = true;
    });

    gpsEnabled = await Geolocator().isLocationServiceEnabled();

    if (gpsEnabled) {
      Map<String, dynamic> userLocation =
          await Provider.of<MapProvider>(context, listen: false)
              .currentLocation();
      widget.updatePickUpLodation(
          userLocation['name'], userLocation['position'], Icons.pin_drop);

      setState(() {
        loading = false;
      });
      // Provider.of<CurrentTripProvider>(context, listen: false)
      //     .currentTripInfo
      //     .lindId = widget.line.id;
      // Provider.of<CurrentTripProvider>(context, listen: false)
      //     .currentTripInfo
      //     .lineName = '${widget.line.from}+${widget.line.to}';
      // Provider.of<CurrentTripProvider>(context, listen: false)
      //     .currentTripInfo
      //     .finalCost = widget.line.cost;

      // Navigate to Info Screen
      // Navigator.of(context).pushNamed(StartARide.routeName, arguments: {
      //   "line": {
      //     "from": widget.line.from,
      //     "to": widget.line.to,
      //     "lineId": widget.line.id,
      //     "cost": widget.line.cost
      //   },
      //   "destination": {
      //     "name": dropoffLocation.name,
      //     "coordinate": dropoffLocation.coordinates,
      //   },
      // });
      // Navigator.of(context).pushNamed(RideInfo.routeName);
      // widget.cancelMethod();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    retreiveLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 32.0),
            padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: loading
                ? Column(children: <Widget>[
                    SpinKitCircle(color: Theme.of(context).primaryColor),
                    SizedBox(height: 8),
                    Text("جاري تحديد موقعك ...",
                        style: TextStyle(color: Colors.grey))
                  ])
                : Column(children: <Widget>[
                    Icon(Icons.location_on,
                        size: 32, color: Theme.of(context).primaryColor),
                    SizedBox(height: 8),
                    Text("برجاء تشغيل خدمه تحديد المواقع لديك",
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 32, child: Divider()),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: retreiveLocation,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Theme.of(context).primaryColor),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.refresh,
                                      color: Colors.white, size: 20),
                                  SizedBox(width: 4),
                                  Text("إعادة المحاولة",
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.cancelMethod,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Colors.red),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.close,
                                      color: Colors.white, size: 20),
                                  SizedBox(width: 4),
                                  Text("الغاء",
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          )
                        ])
                  ]),
          )
        ]);
  }
}

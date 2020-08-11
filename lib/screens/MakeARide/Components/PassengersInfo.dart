// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Tracking.dart';
// Models
import 'package:clax/models/PassengerInfo.dart';
// Widgets
import 'package:clax/widgets/null.dart';
import 'package:clax/widgets/BottomSheetTitle.dart';

class PassengersInfo extends StatefulWidget {
  @override
  _PassengersInfoState createState() => _PassengersInfoState();
}

class _PassengersInfoState extends State<PassengersInfo> {
  bool loading = true;
  LatLng currentLocation;
  List<PassengerInfo> passengers = [];
  List<int> distances = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentLocation = Provider.of<TrackingProvider>(context).currentLocation;
    passengers = Provider.of<TrackingProvider>(context).passengers;
    if (passengers.length > 0 && loading == true)
      setState(() {
        loading = false;
      });
  }

  Future<List<int>> getDistances() async {
    List<int> distances = [];
    for (var i = 0; i < passengers.length; i++) {
      int distance = (await Geolocator().distanceBetween(
              currentLocation.latitude,
              currentLocation.longitude,
              passengers[i].locationCoords.latitude,
              passengers[i].locationCoords.latitude))
          .ceil();
      if (distance < 1000)
        // Code
        print("asd");
      else
        distances.add(distance);
    }
    return distances;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BottomSheetTitle(
            title: "معلومات الرحلات",
            icon: Icons.info,
          ),
          passengers.length == 0
              ? Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child:
                      Center(child: NullContent(things: "ركاب", vPadding: 10)))
              : Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: passengers
                              .map((e) => Row(
                                    children: <Widget>[
                                      Icon(Icons.location_on,
                                          color: Colors.grey[350]),
                                      SizedBox(width: 4),
                                      Text(e.locationName)
                                    ],
                                  ))
                              .toList(),
                        ),
                        Column(
                            children: passengers
                                .map((e) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(e.seats.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'Product Sans',
                                                  color: Colors.grey)),
                                          Text(" ركاب",
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        ]))
                                .toList()),
                        FutureBuilder(
                            future: getDistances(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<int>> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Text('00.00 م');
                                default:
                                  if (snapshot.hasError)
                                    return Text('${00.00} م');
                                  else
                                    return Column(
                                        children: snapshot.data
                                            .map(
                                              (e) => Text(
                                                  e > 1000
                                                      ? '${e / 1000} كم'
                                                      : '$e م',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Product Sans')),
                                            )
                                            .toList());
                              }
                            })
                      ]),
                ),

          //    Row(children: <Widget>[

          //                       ]),
          //                       Row(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.start,
          //                           children: <Widget>[
          //                             Text(
          //                                 passengers[index]
          //                                     .seats
          //                                     .toString(),
          //                                 style: TextStyle(
          //                                     fontFamily: 'Product Sans',
          //                                     color: Colors.grey)),
          //                             Text(" ركاب",
          //                                 style: TextStyle(
          //                                     color: Colors.grey)),
          //                           ]),
          // ],))

          // FutureBuilder(
          //     future: getDistances(),
          //     builder: (BuildContext context,
          //         AsyncSnapshot<List<int>> snapshot) {
          //       switch (snapshot.connectionState) {
          //         case ConnectionState.waiting:
          //           return new Text('Loading....');
          //         default:
          //           if (snapshot.hasError)
          //             return new Text('Error: ${snapshot.error}');
          //           else
          //             return Container(
          //               color: Colors.white,
          //               padding: EdgeInsets.symmetric(
          //                   horizontal: 16, vertical: 8),
          //               child: ListView.builder(
          //                 itemCount: passengers.length,
          //                 itemExtent: 40,
          //                 itemBuilder: (context, index) => Container(
          //                   height: 60,
          //                   width: 500,
          //                   child: Row(
          //                     mainAxisAlignment:
          //                         MainAxisAlignment.spaceBetween,
          //                     children: <Widget>[
          //                       Row(children: <Widget>[
          //                         Icon(Icons.location_on,
          //                             color: Colors.grey[350]),
          //                         SizedBox(width: 4),
          //                         Text(passengers[index].locationName)
          //                       ]),
          //                       Row(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.start,
          //                           children: <Widget>[
          //                             Text(
          //                                 passengers[index]
          //                                     .seats
          //                                     .toString(),
          //                                 style: TextStyle(
          //                                     fontFamily: 'Product Sans',
          //                                     color: Colors.grey)),
          //                             Text(" ركاب",
          //                                 style: TextStyle(
          //                                     color: Colors.grey)),
          //                           ]),
          //                       Text('${snapshot.data[index]}',
          //                           style: TextStyle(
          //                               fontFamily: 'Product Sans')),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             );
          //       }
          //     },
          //   )
          //  loading
          //     ? Container(
          //         padding: EdgeInsets.symmetric(vertical: 20),
          //         color: Colors.white,
          //         child: SpinKitCircle(color: primaryColor),
          //       )
          //     : Container(
          //         color: Colors.white,
          //         padding:
          //             EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //         child: Column(children: getDistances()))
        ],
      ),
    );
  }
}

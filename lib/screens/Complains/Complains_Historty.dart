// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Complains.dart';
import 'package:clax/providers/Trips.dart';
// Models
import 'package:clax/models/Complain.dart';
import 'package:clax/models/Trip.dart';
import 'package:clax/models/Error.dart';
// Widgets
import 'package:clax/widgets/null.dart';
import 'package:clax/screens/Complains/widgets/Card_ComplainHistory.dart';

class ComplaintsHistory extends StatefulWidget {
  static const routeName = '/complaints/complaintsHistory';
  @override
  _ComplaintsHistoryState createState() => _ComplaintsHistoryState();
}

class _ComplaintsHistoryState extends State<ComplaintsHistory> {
  bool loading = false;
  ScrollController _controller = ScrollController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _tripsProvider = Provider.of<TripsProvider>(context);
    var _complainsProvider = Provider.of<ComplainsProvider>(context);
    List<Trip> trips = _tripsProvider.trips ?? [];
    List<ComplainModel> complains = _complainsProvider.complains ?? [];
    complains.sort((a, b) => b.date.compareTo(a.date));
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            Builder(
              builder: (context) => IconButton(
                  icon: loading
                      ? SpinKitThreeBounce(
                          size: 10,
                          color: Colors.white,
                        )
                      : Icon(Icons.refresh),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    ServerResponse result =
                        await _complainsProvider.serverData();
                    setState(() {
                      loading = false;
                    });
                    if (!result.status)
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(result.message,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.white))));
                  }),
            ),
          ],
          elevation: 0.0,
          title: Text(
            'الشكاوى السابقة',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          )),
      body: complains.length > 0
          ? ListView.builder(
              controller: _controller,
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemBuilder: (ctx, index) {
                Trip trip = trips
                    .where((element) => element.id == complains[index].tripId)
                    .toList()[0];
                return FlatButton(
                  color: Colors.white,
                  textTheme: ButtonTextTheme.primary,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        '/payment/complaints/complaintsHistory/complaintDetails',
                        arguments: {
                          'complain': complains[index],
                          "trip": trip
                        });
                  },
                  child: ComplainHistoryCard(
                    complain: complains[index],
                    trip: trip,
                  ),
                );
              },
              itemCount: complains.length,
            )
          : Container(
              alignment: Alignment.center,
              child: NullContent(
                things: "شكاوي",
              ),
            ),
    );
  }
}

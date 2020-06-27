import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Provider/Complains.dart';
import 'package:flutter_complete_guide/Provider/Trips.dart';
import 'package:flutter_complete_guide/models/Complain.dart';
import 'package:flutter_complete_guide/models/Trip.dart';
import 'package:flutter_complete_guide/widgets/null.dart';
import 'package:provider/provider.dart';
import '../widgets/Card_ComplainHistory.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ComplaintsHistory extends StatefulWidget {
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
    var _tripsProvider = Provider.of<Trips>(context);
    var _complainsProvider = Provider.of<Complains>(context);
    List<Trip> trips = _tripsProvider.trips ?? [];
    List<Complain> complains = _complainsProvider.complains ?? [];
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
                    bool result = await _complainsProvider.fetchData();
                    if (result)
                      setState(() {
                        loading = false;
                      });
                    else {
                      setState(() {
                        loading = false;
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.white))));
                    }
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

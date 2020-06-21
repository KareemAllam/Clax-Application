// Flutter's Material Compoments
import 'package:flutter/material.dart';
// Dart & Other Package
import 'dart:async';
import 'package:provider/provider.dart';
// Provider
import 'package:clax/providers/RideSettings.dart';

class Seats extends StatefulWidget {
  @override
  _SeatsState createState() => _SeatsState();
}

class _SeatsState extends State<Seats> {
  bool tapped = false;
  double yTop = 200;
  double xLeft;
  double xRight = 5;
  double yBottom;
  int seats;
  Timer timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void resetTimer() {
    if (timer != null) timer.cancel();
    timer = Timer(Duration(seconds: 3), () => setState(() => tapped = false));
    setState(() => tapped = true);
  }

  @override
  Widget build(BuildContext context) {
    seats = Provider.of<TripSettingsProvider>(context).currnetSeats;
    double topBar = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double scaffoldHeight = height - topBar - 120;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
      top: yTop,
      left: xLeft,
      right: xRight,
      bottom: yBottom,
      child: GestureDetector(
        onTap: resetTimer,
        onPanEnd: (_) {
          if (xRight != null) {
            if (xRight < width / 2) {
              xRight = 5;
              xLeft = null;
            } else {
              xRight = null;
              xLeft = 5;
            }
          } else {
            if (xLeft < width / 2) {
              xRight = null;
              xLeft = 5;
            } else {
              xRight = 5;
              xLeft = null;
            }
          }
          setState(() {});
        },
        onPanUpdate: (tapInfo) {
          double resultWidth = xRight == null
              ? xLeft + tapInfo.delta.dx
              : xRight - tapInfo.delta.dx;
          double resultHeight = yTop + tapInfo.delta.dy;
          if (resultWidth < width - 110 &&
              resultWidth > 0 &&
              resultHeight < scaffoldHeight + 10 &&
              resultHeight > 0) {
            setState(() {
              xRight == null
                  ? xLeft += tapInfo.delta.dx
                  : xRight -= tapInfo.delta.dx;
              yTop += tapInfo.delta.dy;
            });
          }
        },
        child: tapped
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 2,
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      color: Colors.grey[300],
                      child: IconButton(
                        padding: EdgeInsets.all(10),
                        iconSize: 24,
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        icon: Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          resetTimer();
                          if (seats <= 11) {
                            setState(() {
                              seats += 1;
                            });
                            Provider.of<TripSettingsProvider>(context,
                                    listen: false)
                                .currnetSeats += 1;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        seats.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Product Sans'),
                        strutStyle: StrutStyle(forceStrutHeight: true),
                      ),
                    ),
                    Container(
                        color: Colors.grey[300],
                        child: IconButton(
                            padding: EdgeInsets.all(10),
                            iconSize: 24,
                            constraints: BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            icon: Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              resetTimer();
                              if (seats > 1) {
                                setState(() {
                                  seats -= 1;
                                });
                                Provider.of<TripSettingsProvider>(context,
                                        listen: false)
                                    .currnetSeats -= 1;
                              }
                            }))
                  ],
                ))
            : Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.event_seat,
                  color: Colors.white,
                )),
      ),
    );
  }
}

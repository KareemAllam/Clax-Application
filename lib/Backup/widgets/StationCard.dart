import 'package:flutter/material.dart';
import 'package:clax/models/Station.dart';

class StationCard extends StatelessWidget {
  final dynamic position;
  final StationModel station;
  final Function onSelect;
  StationCard({this.position, this.station, this.onSelect});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(station);
      },
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              // flex: 1,
              child: position == null
                  // Middle Station
                  ? Stack(
                      alignment: Alignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.remove,
                          size: 12,
                          color: Theme.of(context).primaryColor,
                        ),
                        Container(
                          child: VerticalDivider(
                              color: Theme.of(context).primaryColor,
                              // width: 14,
                              thickness: 1),
                        )
                      ],
                    )
                  : position == false
                      // Stating Station
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(flex: 2, child: Container()),
                            Flexible(
                                flex: 3,
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.radio_button_unchecked,
                                      size: 12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Expanded(
                                      child: VerticalDivider(
                                          color: Theme.of(context).primaryColor,
                                          width: 14,
                                          thickness: 1),
                                    )
                                  ],
                                )),
                          ],
                        )
                      // Ending Station
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.up,
                          // mainAxisSize: MainAxisSize.min,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(flex: 2, child: Container()),
                            Flexible(
                                flex: 3,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: VerticalDivider(
                                          color: Theme.of(context).primaryColor,
                                          width: 14,
                                          thickness: 1),
                                    ),
                                    Icon(
                                      Icons.brightness_1,
                                      size: 12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ],
                                )),
                          ],
                        )),
          Flexible(
              flex: 8,
              child: Container(
                margin: EdgeInsets.only(top: 5, left: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(station.name,
                    strutStyle: StrutStyle(forceStrutHeight: true),
                    style: Theme.of(context).textTheme.bodyText2
                    // .copyWith(fontWeight: FontWeight.bold),
                    ),
              ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PickupInfo extends StatelessWidget {
  final Map pickuplocation;
  final Function clearPickUpLocation;
  PickupInfo(this.pickuplocation, this.clearPickUpLocation);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16, top: 0),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border(
                  top: BorderSide(color: Theme.of(context).primaryColor))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    pickuplocation['icon'],
                    color: Theme.of(context).accentColor,
                    size: 28,
                  ),
                  SizedBox(width: 28),
                  Text(pickuplocation['name'],
                      strutStyle: StrutStyle(forceStrutHeight: true),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.white)),
                ],
              ),
              Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: clearPickUpLocation,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

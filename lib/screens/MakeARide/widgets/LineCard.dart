import 'package:clax/models/Station.dart';
import 'package:flutter/material.dart';

class LineCard extends StatelessWidget {
  final Line line;
  final Function onTap;
  LineCard({this.line, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(line);
      },
      child: Container(
        margin: EdgeInsets.only(top: 5, left: 7, right: 7),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.radio_button_unchecked,
                            size: 12,
                            color: Theme.of(context).primaryColor,
                          ),
                          Flexible(
                            child: VerticalDivider(
                                color: Theme.of(context).primaryColor,
                                width: 12,
                                thickness: 1),
                          ),
                          Icon(
                            Icons.brightness_1,
                            size: 12,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            line.from,
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            line.to,
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text('محافظات',
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.black45)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text('${line.cost} جنيه',
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.white)),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

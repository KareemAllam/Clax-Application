import 'package:flutter/material.dart';
import 'package:clax/models/Line.dart';

class LineInfo extends StatelessWidget {
  final LineModel line;
  final Function swapDirection;
  final Function clearLine;
  LineInfo(this.line, this.swapDirection, this.clearLine);
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        padding: EdgeInsets.only(bottom: 16, left: 16, right: 8, top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.radio_button_unchecked,
                        color: Theme.of(context).accentColor, size: 16),
                    SizedBox(
                      height: 25,
                      child: VerticalDivider(
                          color: Theme.of(context).accentColor,
                          width: 12,
                          thickness: 1),
                    ),
                    Icon(Icons.radio_button_checked,
                        color: Theme.of(context).accentColor, size: 24),
                  ],
                )),
            SizedBox(width: 24),
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          line.from,
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(" - محافظة الغربية",
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.grey))
                      ],
                    ),
                    Divider(
                      color: Colors.white38,
                      endIndent: 10,
                    ),
                    Row(children: <Widget>[
                      Text(
                        line.to,
                        strutStyle: StrutStyle(forceStrutHeight: true),
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(" - محافظة الغربية  ",
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.grey))
                    ])
                  ],
                )),
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Material(
                      color: Theme.of(context).primaryColor,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: swapDirection,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.import_export,
                              size: 24, color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Material(
                      color: Theme.of(context).primaryColor,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: clearLine,
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
                )),
          ],
        ),
      ),
    );
  }
}

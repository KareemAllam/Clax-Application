import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

showNotification(BuildContext context, String title, String subtitle,
    {Function cb, Widget trailing}) {
  showOverlayNotification(
    (contex) => SafeArea(
      child: GestureDetector(
        onTap: cb,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.grey[350],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title,
                        style:
                            Theme.of(context).textTheme.subtitle2.copyWith()),
                    Text(subtitle,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.black45))
                  ],
                ),
                trailing ??
                    Image.asset(
                      'assets/images/logo.png',
                      height: 40,
                    )
              ]),
        ),
      ),
    ),
  );
}

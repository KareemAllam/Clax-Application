import 'package:flutter/material.dart';

class FormGeneral extends StatelessWidget {
  final String title;
  final String placeholder;
  final Widget widget;

  FormGeneral({this.title, this.widget, this.placeholder});
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding:
                EdgeInsets.only(right: width * 0.05, bottom: height * 0.0054),
            // width: double.infinity,
            child: Text(
              title,
              style: Theme.of(context).textTheme.subtitle2,
            )),
        widget,
        if (placeholder != null)
          Container(
            // width: double.infinity,
            padding: EdgeInsets.only(
                top: height * 0.003, left: 20, right: width * 0.05, bottom: 0),
            child: Text(placeholder,
                style: placeholder.contains("فضلك")
                    ? Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Theme.of(context).primaryColor)
                    : Theme.of(context).textTheme.caption),
          )
      ],
    );
  }
}

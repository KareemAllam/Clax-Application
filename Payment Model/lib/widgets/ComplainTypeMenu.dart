import 'dart:core';
import 'package:flutter/material.dart';

class ComplainsTypeDropdown extends StatefulWidget {
  final Function changeOriginal;
  const ComplainsTypeDropdown(this.changeOriginal);
  State createState() => ComplainsTypeDropdownState();
}

class ComplainsTypeDropdownState extends State<ComplainsTypeDropdown> {
  String selectedType;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            width: 0.5,
            color: Theme.of(context).secondaryHeaderColor,
            style: BorderStyle.solid),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            Icons.directions_transit,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: width * 0.05),
          Expanded(
            flex: 2,
            child: DropdownButton<String>(
              elevation: 3,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Theme.of(context).secondaryHeaderColor),
              hint: Text("اختار الرحلة المناسبة",
                  style: Theme.of(context).textTheme.headline6),
              value: selectedType,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              underline: SizedBox(
                height: 1,
              ),
              onChanged: (String value) {
                widget.changeOriginal(value);
                setState(() {
                  selectedType = value;
                });
              },
              items: [
                DropdownMenuItem(
                    child: Text('متوسط',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.green)),
                    value: "متوسط"),
                DropdownMenuItem(
                    child: Text("هام",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.amber)),
                    value: "هام"),
                DropdownMenuItem(
                    child: Text("عاجل",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.red)),
                    value: "عاجل"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

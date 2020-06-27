import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  final String title;
  final String placeholder;
  final TextEditingController description;
  FormInput({this.title, this.placeholder, this.description});
  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(children: [
      Container(
          padding:
              EdgeInsets.only(right: width * 0.05, bottom: height * 0.0054),
          width: double.infinity,
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.subtitle2,
          )),
      Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.0054, horizontal: width * 0.05),
        height: height * 0.3,
        child: TextField(
          enabled: true,
          maxLength: 250,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: widget.description,
          cursorColor: Theme.of(context).primaryColor,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Color(0xff212121)),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            hintText: widget.placeholder,
            hintStyle: widget.placeholder.contains("فضلك")
                ? Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Theme.of(context).primaryColor,
                    )
                : Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.grey),
            counter: SizedBox(),
            icon: Icon(
              Icons.power_input,
              color: Theme.of(context).primaryColor,
            ),
            border: InputBorder.none,
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border.all(
              color: Theme.of(context).secondaryHeaderColor, width: 0.5),
        ),
      ),
    ]);
  }
}
